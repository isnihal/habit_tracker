import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/task_state.dart';
import 'package:habit_tracker/persistance/hive_data_store.dart';
import 'package:habit_tracker/ui/task/task_with_name.dart';
import 'package:hive/hive.dart';

import '../../models/task.dart';

class TaskWithNameLoader extends ConsumerWidget {

  final Task task;

  const TaskWithNameLoader({Key? key,required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final _dataStore = ref.watch(dataStoreProvider);

    return ValueListenableBuilder(
      valueListenable: _dataStore.getTasksStateBoxListenable(task: task),
      builder: (context,Box<TaskState> box,_) {

        final isBoxNull = box.get(task.id)==null;

        return TaskWithName(
          task: task,
          isCompleted: isBoxNull? false:box.get(task.id)!.completed,
          onComplete: (completed){
            print('Storing to hive');
            _dataStore.setTaskState(task, completed);
          },
        );
      }
    );
  }
}
