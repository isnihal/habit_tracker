import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/persistance/hive_data_store.dart';
import 'package:habit_tracker/ui/home/home_page.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final _hiveDatastore = HiveDataStore();
  await _hiveDatastore.init();
  await _hiveDatastore.addFrontPageTasks([
    Task.create(name: 'Take Vitamins', iconString: AppAssets.vitamins),
    Task.create(name: 'Cycle to Work', iconString: AppAssets.bike),
    Task.create(name: 'Wash Your Hands', iconString: AppAssets.washHands),
    Task.create(name: 'Wear a Mask', iconString: AppAssets.mask),
    Task.create(name: 'Brush Your Teeth', iconString: AppAssets.toothbrush),
    Task.create(name: 'Floss Your Teeth', iconString: AppAssets.dentalFloss),
  ]);

  await _hiveDatastore.addBackPageTasks([
    Task.create(name: 'Eat a Healthy Meal', iconString: AppAssets.carrot),
    Task.create(name: 'Walk the Dog', iconString: AppAssets.dog),
    Task.create(name: 'Do Some Coding', iconString: AppAssets.html),
    Task.create(name: 'Meditate', iconString: AppAssets.meditation),
    Task.create(name: 'Do 10 Pushups', iconString: AppAssets.pushups),
    Task.create(name: 'Sleep 8 Hours', iconString: AppAssets.rest),
  ]);

  runApp(
      ProviderScope(
        overrides: [
          dataStoreProvider.overrideWithValue(_hiveDatastore),
        ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
