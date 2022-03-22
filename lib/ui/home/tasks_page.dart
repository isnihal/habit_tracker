import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/persistance/hive_data_store.dart';
import 'package:habit_tracker/ui/home/tasks_grid.dart';
import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import '../../models/task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {

    final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

    return Consumer(
      builder: (_,ref,__) {

        final _hiveDataStore = ref.watch<HiveDataStore>(dataStoreProvider);

        return PageFlipBuilder(
            key: _pageFlipKey,
            frontBuilder: (_)=> ValueListenableBuilder(
              valueListenable: _hiveDataStore.getFrontPageTasksBoxListenable(),
              builder: (context,Box<Task> box, widget) {
                return TaskGrid(
                  key: ValueKey(1),
                  tasks: box.values.toList(),
                  onFlip: () => _pageFlipKey.currentState?.flip(),
                );
              },
            ),
            backBuilder: (_) => ValueListenableBuilder(
              valueListenable: _hiveDataStore.getBackPageTasksBoxListenable(),
              builder: (context,Box<Task> box, widget) {
                return TaskGrid(
                  key: ValueKey(2),
                  tasks: box.values.toList(),
                  onFlip: () => _pageFlipKey.currentState?.flip(),
                );
              },
            )
        );
      }
    );
  }
}
