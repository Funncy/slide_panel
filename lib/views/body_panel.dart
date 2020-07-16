

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_panel/models/is_opened_provider.dart';

class BodyPanel extends StatefulWidget {
  final Widget body;
  final bool slideOffBodyTap;

  const BodyPanel({Key key, this.body, this.slideOffBodyTap}) : super(key: key);
  @override
  _BodyPanelState createState() => _BodyPanelState();
}

class _BodyPanelState extends State<BodyPanel> {
  @override
  Widget build(BuildContext context) {
    IsOpenedProvider isOpenedProvider = Provider.of<IsOpenedProvider>(context);
    if (widget.slideOffBodyTap) {
      return GestureDetector(
        onTap: () {
          isOpenedProvider.setOpenLeftState(false);
          isOpenedProvider.setOpenRightState(false);
        },
        child: widget.body,
      );
    }
    return widget.body;
  }
}
