import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/persistance/hive_data_store.dart';
import 'package:habit_tracker/ui/common_widgets/page_flip_builder.dart';
import 'package:habit_tracker/ui/home/tasks_grid.dart';
import 'package:hive/hive.dart';

import '../../models/task.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final _hiveDataStore = ref.watch<HiveDataStore>(dataStoreProvider);
    final GlobalKey<PageFlipBuilderState> _pageFlipStateKey = GlobalKey<PageFlipBuilderState>();

    return PageFlipBuilder(
        key: _pageFlipStateKey,
        frontPageBuilder: (_)=> ValueListenableBuilder(
          valueListenable: _hiveDataStore.getFrontPageTasksBoxListenable(),
          builder: (context,Box<Task> box, widget) {
            return TaskGrid(
              tasks: box.values.toList(),
              onFlip: ()=> _pageFlipStateKey.currentState?.flip(),
            );
          },
        ),
        backPageBuilder: (_) => ValueListenableBuilder(
          valueListenable: _hiveDataStore.getBackPageTasksBoxListenable(),
          builder: (context,Box<Task> box, widget) {
            return TaskGrid(
              tasks: box.values.toList(),
              onFlip: ()=> _pageFlipStateKey.currentState?.flip(),
            );
          },
        )
    );
  }
}
