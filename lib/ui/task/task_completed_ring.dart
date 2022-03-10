import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class TaskCompletedRing extends StatelessWidget {

  //Arguments
  final String taskIcon;

  //Constructor
  const TaskCompletedRing({Key? key,required this.taskIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Objects
    final theme = AppTheme.of(context);

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: theme.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
