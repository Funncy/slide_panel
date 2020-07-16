import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_panel/models/is_opened_provider.dart';

class LeftSlidePanel extends StatefulWidget {
  final Widget body;
  final double slidePanelWidth;
  final double slidePanelHeight;
  final double slideHandlerWidth;
  final bool appbarIsExist;

  const LeftSlidePanel(
      {Key key,
      this.body,
      this.slidePanelWidth,
      this.slidePanelHeight,
      this.slideHandlerWidth,
      this.appbarIsExist})
      : super(key: key);
  @override
  _LeftSlidePanelState createState() => _LeftSlidePanelState();
}

class _LeftSlidePanelState extends State<LeftSlidePanel>
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

  void close() {
    _animationController.reverse();
  }

  void open() {
    _animationController.forward();
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < widget.slideHandlerWidth;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx >
            (widget.slidePanelWidth - widget.slideHandlerWidth);
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / widget.slidePanelWidth;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details, IsOpenedProvider isOpenedProvider) {
    if (_animationController.isDismissed) {
      isOpenedProvider.setOpenLeftState(false);
      return;
    }

    if (_animationController.isCompleted) {
      isOpenedProvider.setOpenLeftState(true);
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      if (visualVelocity > 0) {
        isOpenedProvider.setOpenLeftState(true);
      } else {
        isOpenedProvider.setOpenLeftState(false);
      }

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      isOpenedProvider.setOpenLeftState(false);
      close();
    } else {
      isOpenedProvider.setOpenLeftState(true);
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    IsOpenedProvider isOpenedProvider = Provider.of<IsOpenedProvider>(context);
    var size = MediaQuery.of(context).size;

    var appbarHeight = widget.appbarIsExist ? AppBar().preferredSize.height : 0;

    if (isOpenedProvider.getIsLeftOpened() == false &&
        _animationController.isCompleted) {
      _animationController.reverse();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final leftSlide = widget.slidePanelWidth * _animationController.value;
        return Positioned(
          top: (size.height - widget.slidePanelHeight) / 2 - appbarHeight,
          left: -widget.slidePanelWidth,
          child: Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()..translate(leftSlide),
              child: isOpenedProvider.getIsRightOpened()
                  ? GestureDetector(
                      onTap: () {
                        isOpenedProvider.setOpenRightState(false);
                      },
                      child: widget.body)
                  : GestureDetector(
                      onHorizontalDragStart: _onDragStart,
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
