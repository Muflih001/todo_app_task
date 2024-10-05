import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_task/controllers/settingsScreenController.dart';
import 'package:todo_app_task/models/task_model.dart';
import 'package:todo_app_task/views/splashScreen/splashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var box = await Hive.openBox('taskBox');
  var box1 = await Hive.openBox('categoryBox');
  var box2 = await Hive.openBox("profileBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Settingsscreencontroller(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
