

import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget{

@override
Widget build(BuildContext context){
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