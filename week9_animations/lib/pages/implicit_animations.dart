import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with SingleTickerProviderStateMixin {
  bool isScaledUp = false;
  bool isCapsule = false;
  double rotationAngle = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    while (true) {
      setState(() {
        isScaledUp = true; 
      });
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        rotationAngle += 360; 
      });
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isCapsule = true; 
      });
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isScaledUp = false; 
        isCapsule = false;
        rotationAngle = 0.0; 
      });
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Implicit Animation')),
      body: Center(
        child: AnimatedRotation(
          duration: Duration(seconds: 1),
          turns: rotationAngle / 360,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: isScaledUp ? 200 : 20, 
            height: isScaledUp ? (isCapsule ? 60 : 200) : 20, 
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(isCapsule ? 30 : 0),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: Duration(seconds: 1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isScaledUp ? 20 : 8, 
                ),
                child: Text('Animated Box'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}