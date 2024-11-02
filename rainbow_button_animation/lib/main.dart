import 'package:flutter/material.dart';
import 'package:rainbow_button_animation/rainbow_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RainbowButton()
    );
  }
}
