import 'package:flutter/material.dart';
import 'package:habit_tracker/persistance/hive_data_store.dart';
import 'package:habit_tracker/ui/home/tasks_grid.dart';
import 'package:hive/hive.dart';

import '../../constants/app_assets.dart';
import '../../models/task.dart';
import '../../models/task_preset.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _hiveDataStore = HiveDataStore();

    return ValueListenableBuilder(
      valueListenable: _hiveDataStore.openTasksBox(),
      builder: (context,Box<Task> box, widget) {
        return TaskGrid(
          tasks: box.values.toList(),
        );
      },
    );
  }
}
