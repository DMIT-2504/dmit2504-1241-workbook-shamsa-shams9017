

import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget{

@override
Widget build(BuildContext contex){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Enter Text'
      )
    )
  );
}
}