import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_state.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';

import '../models/task.dart';

class HiveDataStore{

  static const _taskBoxName = 'tasks';
  static const _taskStateBoxName = 'task_state';
  late final Box<Task> _taskBox;
  late final Box<TaskState> _taskStateBox;

  Future<void> init() async{
    //Init Hive Flutter
    await Hive.initFlutter();
    //Register all adaptors here
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    //Open boxes
   await Hive.openBox<Task>(_taskBoxName);
    await Hive.openBox<TaskState>(_taskStateBoxName);
    //Assign boxes
   _taskBox = Hive.box<Task>(_taskBoxName);
   _taskStateBox = Hive.box<TaskState>(_taskStateBoxName);
  }

  Future<void> addTasks(List<Task> tasks) async {
    //_taskBox.clear();
    if(_taskBox.isEmpty) {
      await _taskBox.addAll(tasks);
    }
  }

  ValueListenable<Box<Task>> getTasksBoxListenable() {
    return Hive.box<Task>(_taskBoxName).listenable();
  }

  Future<void> setTaskState(Task task,bool completed) async {
    final _taskState = TaskState(id: task.id, completed: completed);
    await _taskStateBox.put(task.id,_taskState);
  }

  ValueListenable<Box<TaskState>> getTasksStateBoxListenable({required Task task}) {
    return Hive.box<TaskState>(_taskStateBoxName).listenable(keys: <String>[task.id]);
  }

  TaskState getTaskState(Task task){
    return _taskStateBox.get(task.id)??TaskState(id: task.id, completed: false);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref){
  throw UnimplementedError();
});