
import 'package:flutter/material.dart';

ThemeData customTheme(){
  return ThemeData(
       // scaffoldBackgroundColor: Colors.cyan,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark
          
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18.0,
            color: Colors.red
          )
        )
      );
}