import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker/ui/home/tasks_page.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 0),
        child: SafeArea(
          child: TasksPage(),
        )
      )
    );
  }
}
