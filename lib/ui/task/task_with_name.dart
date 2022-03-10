import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/text_styles.dart';
import 'package:habit_tracker/models/task_preset.dart';
import 'package:habit_tracker/ui/task/task_animation.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

import '../../models/task.dart';

class TaskWithName extends StatelessWidget {

  final Task task;

  const TaskWithName({Key? key,required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TaskAnimation(taskIcon: task.iconString,),
        ),
        SizedBox(height: 16,),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent
          ),
        )
      ],
    );
  }
}
