import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
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

  factory Task.create({required String name,required String iconString}){
    final id = Uuid().v1();
    return Task(
      id: id,
      iconString: iconString,
      name: name,
    );
  }
}