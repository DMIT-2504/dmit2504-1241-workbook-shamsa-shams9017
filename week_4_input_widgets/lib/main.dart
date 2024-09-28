import 'package:flutter/material.dart';
import 'package:week_4_input_widgets/simple_text_field.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SimpleTextField()
      ),
    );
  }
}
