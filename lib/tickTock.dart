import 'package:flutter/material.dart';
import 'package:tick_tock_animation/radialText.dart';

class TickTock extends StatelessWidget {
  final TextStyle verticalStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  List<Widget> getVerticalTextArary() {
    return [
      Text(
        "T",
        style: verticalStyle,
      ),
      Text(
        " ",
        style: verticalStyle,
      ),
      Text(
        "C",
        style: verticalStyle,
      ),
      Text(
        "K",
        style: verticalStyle,
      ),
    ];
  }

  Column getVerticalComponent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: getVerticalTextArary(),
    );
  }

  Widget getRadialComponent() {
    return RadialText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          getVerticalComponent(),
          getRadialComponent(),
        ],
      ),
    );
  }
}
