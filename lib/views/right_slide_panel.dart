import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_panel/models/is_opened_provider.dart';

class RightSlidePanel extends StatefulWidget {
  final Widget body;
  final double slidePanelWidth;
  final double slidePanelHeight;
  final double slideHandlerWidth;
  final bool appbarIsExist;

  const RightSlidePanel(
      {Key key,
      this.body,
      this.slidePanelWidth,
      this.slidePanelHeight,
      this.slideHandlerWidth,
      this.appbarIsExist})
      : super(key: key);
  @override
  _RightSlidePanelState createState() => _RightSlidePanelState();
}

class _RightSlidePanelState extends State<RightSlidePanel>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: toggleDuration);
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void _onDragStart(DragStartDetails details, Size size) {
    bool isDragOpenFromRight = _animationController.isDismissed &&
        details.globalPosition.dx > widget.slidePanelWidth;
    bool isDragCloseFromLeft = _animationController.isCompleted &&
        details.globalPosition.dx < (size.width - widget.slidePanelWidth);
    _canBeDragged = isDragOpenFromRight || isDragCloseFromLeft;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / widget.slidePanelWidth;
      _animationController.value -= delta;
    }
  }

  void _onDragEnd(DragEndDetails details, IsOpenedProvider isOpenedProvider) {
    if (_animationController.isDismissed) {
      isOpenedProvider.setOpenRightState(false);
      return;
    }
    if (_animationController.isCompleted) {
      isOpenedProvider.setOpenRightState(true);
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      if (visualVelocity > 0) {
        isOpenedProvider.setOpenRightState(false);
      } else {
        isOpenedProvider.setOpenRightState(true);
      }

      _animationController.fling(velocity: -visualVelocity);
    } else if (_animationController.value < 0.5) {
      isOpenedProvider.setOpenRightState(false);
      close();
    } else {
      isOpenedProvider.setOpenRightState(true);
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    IsOpenedProvider isOpenedProvider = Provider.of<IsOpenedProvider>(context);
    var appbarHeight = widget.appbarIsExist ? AppBar().preferredSize.height : 0;

    if (isOpenedProvider.getIsRightOpened() == false &&
        _animationController.isCompleted) {
      _animationController.reverse();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final rightSlide = -widget.slidePanelWidth * _animationController.value;
        return Positioned(
          top: (size.height - widget.slidePanelHeight) / 2 - appbarHeight,
          left: size.width - widget.slideHandlerWidth,
          child: Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()..translate(rightSlide),
              child: isOpenedProvider.getIsLeftOpened() == true
                  ? GestureDetector(
                      onTap: () {
                        isOpenedProvider.setOpenLeftState(false);
                      },
                      child: widget.body)
                  : GestureDetector(
                      onHorizontalDragStart: (details) =>
                          _onDragStart(details, size),
                      onHorizontalDragUpdate: _onDragUpdate,
                      onHorizontalDragEnd: (details) =>
                          _onDragEnd(details, isOpenedProvider),
                      child: widget.body,
                    )),
        );
      },
    );
  }
}
