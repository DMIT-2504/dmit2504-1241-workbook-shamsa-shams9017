import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _borderRadiusAnimation;

  bool isScaledUp = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
     
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _borderRadiusAnimation = Tween<double>(begin: 0, end: 30).animate(_controller);

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    while (true) {
      _controller.forward();
      await Future.delayed(Duration(seconds: 3));

      _controller.forward();
      await Future.delayed(Duration(seconds: 3));

      _controller.forward();
      setState(() {
        isScaledUp = true;
      });
      await Future.delayed(Duration(seconds: 3));

      _controller.reverse();
      setState(() {
        isScaledUp = false;
      });
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explicit Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return RotationTransition(
              turns: _rotationAnimation,
              child: Container(
                width: 200 * _scaleAnimation.value,
                height: (isScaledUp ? 60 : 200) * _scaleAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                ),
                child: Center(
                  child: Text(
                    'Animated Box',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * _scaleAnimation.value,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
