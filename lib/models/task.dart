import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String iconString;

  Task({required this.id, required this.name,required this.iconString});
}