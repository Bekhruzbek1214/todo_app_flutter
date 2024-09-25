import 'package:flutter/material.dart';
import 'package:todo_app/feature/screen/splash/splash_screen.dart';

import 'data/local/shared_preference.dart';
import 'feature/screen/tab_bar/tab_bar.dart';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.init();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarScreen()
    );
  }
}
