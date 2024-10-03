
import 'package:flutter/material.dart';
import 'package:week_05_navigation_with_custom_input_fields/page_one.dart';
import 'package:week_05_navigation_with_custom_input_fields/page_two.dart';

// What this app covers:
// - how to navigate between screens
// - how to pass data when navigating
// - how to use a reusable form with custom input fields


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: { //define your routes here if you want to use named routes
        '/pageTwo': (context) => PageTwo(),
        //'/pageTwo': (context) => PageThree(),

      },
      initialRoute: '/',
      home: PageOne(), //set home page as any page you want
      theme: ThemeData(
          primarySwatch: Colors.blue,
          //setting different themes so we can display in the pages
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, secondary: Colors.red)),
              debugShowCheckedModeBanner: false // this is used to show or remove the debug banner at the top right corner
    );
  }
}
