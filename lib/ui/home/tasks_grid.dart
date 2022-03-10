import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_preset.dart';
import 'package:habit_tracker/ui/task/task_with_name.dart';

class TaskGrid extends StatelessWidget {

  final List<TaskPreset> tasks;

  const TaskGrid({Key? key,required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
      itemCount: tasks.length,
      itemBuilder: (ctx,index){
        return TaskWithName(task: tasks[index]);
      },
    );
  }
}
