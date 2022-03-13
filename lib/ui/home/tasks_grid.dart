import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/ui/task/task_with_name_loader.dart';

import 'home_page_bottom_options.dart';

class TaskGrid extends StatelessWidget {

  final List<Task> tasks;
  final VoidCallback onFlip;

  const TaskGrid({Key? key,required this.tasks,required this.onFlip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
            ),
            itemCount: tasks.length,
            itemBuilder: (ctx,index){
              return TaskWithNameLoader(task: tasks[index]);
            },
          ),
        ),
        HomePageBottomOptions(onFlip: ()=>onFlip())
      ],
    );
  }
}
