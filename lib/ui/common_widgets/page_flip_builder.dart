import 'dart:math';

import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {

  final WidgetBuilder frontPageBuilder,backPageBuilder;

  const PageFlipBuilder({Key? key,required this.frontPageBuilder,required this.backPageBuilder}) : super(key: key);

  @override
  State<PageFlipBuilder> createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  bool _showFrontPage = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    _animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeStatusListener(_updateStatus);
    _animationController.dispose();
  }

  void flip(){
    if(_showFrontPage){
      _animationController.forward();
    }
    else{
      _animationController.reverse();
    }
  }

  void _updateStatus(AnimationStatus animationStatus){
    if(animationStatus==AnimationStatus.completed || animationStatus==AnimationStatus.dismissed){
      setState(() {
        _showFrontPage = !_showFrontPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPage(
        animation: _animationController,
        showFrontPage: _showFrontPage,
        frontPageBuilder: (_)=> widget.frontPageBuilder(context),
        backPageBuilder: (_)=> widget.backPageBuilder(context),
    );
  }
}

class AnimatedPage extends AnimatedWidget {

  final bool showFrontPage;
  final WidgetBuilder frontPageBuilder,backPageBuilder;

  const AnimatedPage({
    Key? key,
    required Animation<double> animation,
    required this.showFrontPage,
    required this.frontPageBuilder,
    required this.backPageBuilder
  }) : super(key: key,listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    //Animation value from 0,1 => [0,pi]
    //Show front page from 0-0.5 and back page from 0.5-1
    bool isAnimationFirstHalf = animation.value<0.5;
    //Calculate rotation value
    double rotationValue = animation.value * pi;
    //Calculate rotation angle
    double rotationAngle = isAnimationFirstHalf? rotationValue:pi-rotationValue;
    //Add tilt for perspective value
    double tilt = (animation.value-0.5).abs()-0.5;
    tilt *= isAnimationFirstHalf? -0.03:0.03;
    return Transform(
      transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tilt),
      child: isAnimationFirstHalf? frontPageBuilder(context):backPageBuilder(context),
      alignment: Alignment.center,
    );
  }
}

