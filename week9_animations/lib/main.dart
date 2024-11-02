import 'package:flutter/material.dart';
import 'package:week9_animations/pages/explicit_animations.dart';
import 'package:week9_animations/pages/implicit_animations.dart';
import 'package:week9_animations/pages/transform_anims.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: //PageThree(),
       PageOne(),
       //PageTwo()
    );
  }
}
