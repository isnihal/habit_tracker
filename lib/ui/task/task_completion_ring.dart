import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {

  //Arguments
  final double progress;

  //Constructor
  const TaskCompletionRing({Key? key,required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Objects
    final themeData = AppTheme.of(context);

    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainter(
          progress: progress,
          taskCompletedColor: themeData.accent,
          taskNotCompletedColor: themeData.taskRing
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter{

  //Arguments
  final double progress;
  final Color taskCompletedColor,taskNotCompletedColor;

  //Constructor
  RingPainter({required this.progress,required this.taskCompletedColor,required this.taskNotCompletedColor});

  @override
  void paint(Canvas canvas, Size size) {
    //Setup  properties
    final _thickness = size.width/15.0;
    final _radius = (size.width-_thickness)/2;
    final _center = Offset(size.width/2,size.height/2);

    //Draw the background Ring
    final _backgroundPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = _thickness
    ..style = PaintingStyle.stroke
    ..color = taskNotCompletedColor;

    canvas.drawCircle(_center,_radius, _backgroundPaint);

    //Draw the Completed Arc
    final _foregroundPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = _thickness
    ..style = PaintingStyle.stroke
    ..color = taskCompletedColor;

    canvas.drawArc(Rect.fromCircle(center: _center, radius: _radius), -pi/2, 2*pi*progress, false, _foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    //Redraw the UI only when progress changes
    return oldDelegate.progress!=progress;
  }

}
