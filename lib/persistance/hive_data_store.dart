import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class HiveDataStore{

  static const _hiveBoxName = 'tasks';
  late final Box<Task> _hiveBox;

  Future<void> init() async{
    //Init Hive Flutter
    await Hive.initFlutter();
    //Register all adaptors here
    Hive.registerAdapter<Task>(TaskAdapter());
    //Open boxes
   await Hive.openBox<Task>(_hiveBoxName);
   _hiveBox = Hive.box<Task>(_hiveBoxName);
  }

  Future<void> addTasks(List<Task> tasks) async {
    await _hiveBox.clear();
    await _hiveBox.addAll(tasks);
  }

  ValueListenable<Box<Task>> openTasksBox() {
    return Hive.box<Task>(_hiveBoxName).listenable();
  }
}