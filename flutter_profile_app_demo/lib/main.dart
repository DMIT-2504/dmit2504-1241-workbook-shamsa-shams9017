import 'package:flutter/material.dart';
import 'package:flutter_profile_app_demo/homepage.dart';
import 'package:flutter_profile_app_demo/themes/custom_themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme(),
      home: MyHomePage()
    );
  }
}
 