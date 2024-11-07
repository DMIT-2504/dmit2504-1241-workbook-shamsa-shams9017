import 'package:flutter/material.dart';

import 'models/user.dart';
import 'widgets/user_widget.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: UserWidget(
            user: User(name: 'John', email: 'john@nait.ca'),
          ),
        ),
      ),
    );
  }
}
