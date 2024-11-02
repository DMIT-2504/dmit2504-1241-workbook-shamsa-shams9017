

import 'dart:async';

import 'package:flutter/material.dart';

class RainbowButton extends StatefulWidget {
  @override
  _RainbowbuttonState createState() => _RainbowbuttonState();
}

class _RainbowbuttonState extends State<RainbowButton>{
   Color _buttonColor = Colors.amber;
    final List<Color> _colorList = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.deepOrange,
      Colors.purple,
      Colors.yellow
    ];

    int _colorIndex = 0;

    @override
    void initState(){
      super.initState();
      Timer.periodic(Duration(milliseconds: 300), (timer){
        setState((){
          _colorIndex = (_colorIndex + 1) % _colorList.length;
          _buttonColor = _colorList[_colorIndex];
        });
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(duration: Duration(milliseconds: 300)
      , color: _buttonColor,
      height: 100,
      width: 100,
      child: Text("Rainbow Button")      )
    );

  }

}