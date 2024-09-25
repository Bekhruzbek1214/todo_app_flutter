import 'package:flutter/material.dart';
import 'dart:math';

class CustomClockPainter extends CustomPainter {
  final DateTime dateTime;

  CustomClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    Paint fillBrush = Paint()
      ..color = Colors.white;

    Paint outlineBrush = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Paint hourHandBrush = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    Paint minuteHandBrush = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    Paint secondHandBrush = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Draw the clock face
    canvas.drawCircle(center, radius - 6, fillBrush);
    canvas.drawCircle(center, radius - 6, outlineBrush);

    // Draw the hour hand
    double hourHandX = centerX + radius * 0.5 * cos((dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 - pi / 2);
    double hourHandY = centerY + radius * 0.5 * sin((dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 - pi / 2);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    // Draw the minute hand
    double minuteHandX = centerX + radius * 0.7 * cos(dateTime.minute * 6 * pi / 180 - pi / 2);
    double minuteHandY = centerY + radius * 0.7 * sin(dateTime.minute * 6 * pi / 180 - pi / 2);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandBrush);

    // Draw the second hand
    double secondHandX = centerX + radius * 0.9 * cos(dateTime.second * 6 * pi / 180 - pi / 2);
    double secondHandY = centerY + radius * 0.9 * sin(dateTime.second * 6 * pi / 180 - pi / 2);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandBrush);

    // Draw the hour markers and numbers
    for (int i = 1; i <= 12; i++) {
      double hourMarkerX = centerX + radius * 0.8 * cos(i * 30 * pi / 180 - pi / 2);
      double hourMarkerY = centerY + radius * 0.8 * sin(i * 30 * pi / 180 - pi / 2);

      // Draw the hour markers
      // canvas.drawCircle(Offset(hourMarkerX, hourMarkerY), 4, centerDotBrush);

      // Draw the numbers
      TextSpan span = TextSpan(style: TextStyle(color: Colors.black, fontSize: 14), text: '$i');
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      double textX = hourMarkerX - tp.width / 2;
      double textY = hourMarkerY - tp.height / 2;
      tp.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
