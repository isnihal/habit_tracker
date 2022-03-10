import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/ui/home/tasks_grid.dart';
import 'package:habit_tracker/ui/task/task_animation.dart';
import 'package:habit_tracker/ui/task/task_completion_ring.dart';
import 'package:habit_tracker/ui/task/task_with_name.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

import '../../models/task_preset.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: TaskGrid(
          tasks: const [
            TaskPreset(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
            TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
            TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
            TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
            TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
            TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
          ],
        ),
      )
    );
  }
}
