// @dart=2.9

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(angle: -pi / 2,
      child: CustomPaint(
        painter: ClockPainter(),
      ),
    ),
    );
}
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec takes 360, 1 sec takes 6

  @override
  void paint(Canvas canvas, Size size) {
      var centerX = size.width / 2;
      var centerY = size.height / 2;
      var center = Offset(centerX, centerY);
      var radius = min(centerX, centerY);

      var fillBrush = Paint()
      ..color = Color(0xFF404373);

      var outlineBrush = Paint()
      ..color = Color(0xFFE8E7FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 30;

      var dashBrush = Paint()
      ..color = Color(0xFFE8E7FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 180;

      var centerFillBrush = Paint()
      ..color = Color(0xFFE8E7FF);

      var secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 40;

      var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF697CF9), Color(0xFF4EE9FA)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

      var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEF49A2), Color(0xFFC251FA)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 20;

      canvas.drawCircle(center, radius * 0.75, fillBrush);
      canvas.drawCircle(center, radius * 0.75, outlineBrush);

      var hourHandX = centerX + radius * 0.40 * cos ((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
      var hourHandY = centerX + radius * 0.40 * sin ((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
      canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
     
      var minHandX = centerX + radius * 0.60 * cos (dateTime.minute * 6 * pi / 180);
      var minHandY = centerX + radius * 0.60 * sin (dateTime.minute * 6 * pi / 180);
      canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
      
      var secHandX = centerX + radius * 0.60 * cos (dateTime.second * 6 * pi / 180);
      var secHandY = centerX + radius * 0.60 * sin (dateTime.second * 6 * pi / 180);
      canvas.drawLine(center, Offset(secHandX,secHandY),secHandBrush);



      canvas.drawCircle(center, size.width / 30, centerFillBrush);

      var outerCircleRadius = radius ;
      var innerCircleRadius = radius * 0.9;
      for (double i = 0; i < 360; i += 20) {
        var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
        var y1 = centerY + outerCircleRadius * sin(i * pi / 180);

        var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
        var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
      }
    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}