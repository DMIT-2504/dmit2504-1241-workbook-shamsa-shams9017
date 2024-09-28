import 'package:flutter/material.dart';
import 'package:week_4_input_widgets/textfield_with_controller_stateless.dart';
import 'package:week_4_input_widgets/textfield_with_stateful.dart';
import 'package:week_4_input_widgets/textformfield_stateful.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: //SimpleTextField()
              //SimpleTextFieldController()
              //SimpleTextFieldStateful()
              TextFormFieldStateful()
      ),
    );
  }
}
