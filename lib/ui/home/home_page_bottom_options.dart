import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class HomePageBottomOptions extends StatelessWidget {

  final VoidCallback onFlip;

  const HomePageBottomOptions({Key? key,required this.onFlip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onFlip,
          icon: Icon(Icons.flip,color: AppTheme.of(context).settingsLabel,),
        )
      ],
    );
  }
}
