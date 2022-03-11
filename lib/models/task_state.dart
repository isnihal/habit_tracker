import 'package:habit_tracker/models/task.dart';
import 'package:hive/hive.dart';

part 'task_state.g.dart';

@HiveType(typeId: 1)
class TaskState{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool completed;

  const TaskState({required this.id,required this.completed});
}