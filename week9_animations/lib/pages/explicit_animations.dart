import 'package:flutter/material.dart';
import 'dart:math' as math;

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late AnimationController _shrinkController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _heightAnimation;
  late Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    // init AnimationControllers for scaling, rotating, and shrinking
    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _shrinkController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    //  define scaling animation from small to normal size
    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // define rotation animation for a 360 degree turn
    _rotationAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    // define height animation to shrink to capsule shape
    _heightAnimation = Tween<double>(begin: 200, end: 60).animate(
      CurvedAnimation(parent: _shrinkController, curve: Curves.easeInOut),
    );

    // define border radius animation to create a capsule shape
    _borderRadiusAnimation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _shrinkController, curve: Curves.easeInOut),
    );

    // start the animation sequence
    _startAnimationSequence();
  }

  // animation sequence: scale up, rotate, shrink to capsule, then shrink back to small square
  void _startAnimationSequence() async {
    while (true) {
      // step 1: scale up to normal size, then hold for 2 seconds
      await _scaleController.forward();
      await Future.delayed(const Duration(seconds: 2));

      // step 2: rotate 360 degrees, then hold for 2 seconds
      await _rotateController.forward();
      await Future.delayed(const Duration(seconds: 2));
      _rotateController.reset(); // reset rotation after completing 360 degrees

      // step 3: shrink to capsule shape, then hold for 2 seconds
      await _shrinkController.forward();
      await Future.delayed(const Duration(seconds: 2));

      // step 4: shrink back to very small square shape
      await _scaleController.reverse();
      _shrinkController.reverse(); // reset back to square during shrinking
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    _shrinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complex Animation Sequence')),
      body: Center(
        child: AnimatedBuilder(
          // combine multiple AnimationController objects into a single Listenable object. 
          // This merged Listenable notifies the AnimatedBuilder 
          // whenever any of the included AnimationControllers (_scaleController, _rotateController, _shrinkController) change.
          // this means that its listening to multiple controllers at the same time.
          animation: Listenable.merge([_scaleController, _rotateController, _shrinkController]),
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * math.pi * 2, 
              child: Container(
                width: 200 * _scaleAnimation.value,
                height: _heightAnimation.value * _scaleAnimation.value,
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
