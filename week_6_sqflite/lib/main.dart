import 'package:flutter/material.dart';

// Create an app that takes input and saves a new user in the database
// It should create, read, update and delete users

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'SQFlite demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserPage()
    );
  }
}
