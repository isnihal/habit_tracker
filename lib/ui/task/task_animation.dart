import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker/ui/task/task_completed_ring.dart';
import 'package:habit_tracker/ui/task/task_completion_ring.dart';

import '../theming/app_theme.dart';

class TaskAnimation extends StatefulWidget {

  //Arguments
  final String taskIcon;

  //Constructor
  const TaskAnimation({Key? key,required this.taskIcon}) : super(key: key);

  @override
  State<TaskAnimation> createState() => _TaskAnimationState();
}

class _TaskAnimationState extends State<TaskAnimation> with SingleTickerProviderStateMixin {

  //Objects
  late AnimationController _controller;
  late Animation<double> _curveAnimation;

  bool _showCheck = false;

  @override
  void initState() {
    super.initState();
    //Init Animation Controller
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 750));
    _curveAnimation = _controller.drive(
      CurveTween(curve: Curves.easeInOut)
    );
    //Add a status listener for the animation controller
    _controller.addStatusListener(_showAnimationCompleted);
  }

  void _showAnimationCompleted(AnimationStatus animationStatus){

    //Show a check sign if animation is completed
    if(animationStatus == AnimationStatus.completed){
      if(mounted) {
        setState(() {
          _showCheck = true;
        });
      }
      //Dismiss the check sign after 1 second
      Future.delayed(Duration(seconds: 1),(){
        if(mounted) {
          setState(() {
            _showCheck = false;
          });
        }
      });
    }
  }

  void _addProgress(TapDownDetails details){
    //Add or reset progress when a user taps

    //Progress the animation if it's incomplete
    if(_controller.status!=AnimationStatus.completed) {
      _controller.forward();
    }
    else{
      //Reset Animation, if animation is completed and check sign is not showing
      if(!_showCheck) {
        _controller.value = 0;
      }
    }

  }

  void _cancelProgress(){
    //Cancel progress if user's lift or drag their finger
    if(_controller.status!=AnimationStatus.completed) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = AppTheme.of(context);

    return GestureDetector(
      onTapUp: (_)=> _cancelProgress(),
      onTapDown: _addProgress,
      onTapCancel: _cancelProgress,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context,child) {
          return Stack(
            children: [
              if (_controller.value!=1)
                TaskCompletionRing(progress: _controller.value)
              else
                TaskCompletedRing(taskIcon: widget.taskIcon),
              Positioned.fill(child:CenteredSvgIcon(iconName: _showCheck? AppAssets.check:widget.taskIcon, color: _controller.value!=1.0? theme.taskIcon:theme.accentNegative),)
            ],
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //Remove the status listener
    _controller.removeStatusListener(_showAnimationCompleted);
    //Remove the animation controller
    _controller.dispose();
  }
}
