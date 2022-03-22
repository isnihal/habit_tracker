import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_theme_settings.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker/ui/sliding_panel/theme_selection_list.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
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
        ),
        Stack(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.white,)),
            Center(child: HomePageBottomOptions(onFlip: ()=>onFlip())),
            Positioned(
              bottom: 8,
              child: SlidingPanel(
                direction: SlideDirection.leftToRight,
                child: ThemeSelectionClose(),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 8,
              width: MediaQuery.of(context).size.width-SlidingPanel.leftPanelFixedWidth,
              child: SlidingPanel(
                direction: SlideDirection.rightToLeft,
                child: ThemeSelectionList(
                  availableWidth: MediaQuery.of(context).size.width-SlidingPanel.leftPanelFixedWidth-SlidingPanel.paddingWidth,
                  currentThemeSettings: AppThemeSettings(colorIndex: 0,variantIndex: 0),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
