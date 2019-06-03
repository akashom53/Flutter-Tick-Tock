import 'dart:math';

import 'package:flutter/material.dart';

class RadialText extends StatefulWidget {
  @override
  _RadialTextState createState() => _RadialTextState();
}

class _RadialTextState extends State<RadialText> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  double _globalTick = 0;
  double _globalCounter = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );
    _animation = Tween<double> (
      begin: 0,
      end: 1
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut
      )
    );
    _animation.addListener((){
      setState(() {
        _globalTick = _animation.value;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _globalCounter++;
        if (_globalCounter > 15) {
          _globalCounter = 0;
        }
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _RadialTextPainter(_globalTick + _globalCounter, _globalCounter),
    );
  }
}

class _RadialTextPainter extends CustomPainter {
  String text = "IOIOIOIOIOIOIOIO";
  // String text = "IIIIIIIIIIIIIIII";
  double angle;
  double r = 60;

  double _globalTick;
  double _counter;

  _RadialTextPainter(this._globalTick, this._counter) {
    angle = (pi * 2) / text.length;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(7, 94);
    canvas.rotate(_globalTick * angle - pi/2);
    Paint debugPosPaint = Paint();
    debugPosPaint.color = Colors.green;
    debugPosPaint.style = PaintingStyle.fill;
    for (int i = 0; i < text.length; i++) {
      canvas.save();
      double x = r * cos(angle * i);
      double y = r * sin(angle * i);

      canvas.translate(x, y);
      canvas.rotate(((pi / 2) + angle * i));

      // canvas.drawRect(
      //   Rect.fromLTWH(
      //     -10,
      //     -15,
      //     20,
      //     30,
      //   ),
      //   debugPosPaint,
      // );
      Color color = Colors.grey;
      if (15 - i == _counter) {
        color = Colors.white;
      }
      TextSpan span = TextSpan(
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          text: text[i]);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(
          canvas,
          Offset(
            text[i] == "O" ? -8 : -3,
            -10,
          ));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
