import 'package:flutter/material.dart';
import 'dart:math' as math;


class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transforms')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              // 30 degrees is converted to radians by using 30 * (math.pi / 180)
              angle: -70 * (math.pi / 180),
              child: const Text('Rotate only'),
            ),
            Transform.scale(
              scale: 2,
              child: Transform.translate(
                offset: const Offset(0.0, -50.0), //Moves 0 pixels to the right and 30 pixels down
                child: Transform.rotate(
                  angle: -30 * (math.pi / 180),
                  child: const Text('Scale, translate, and rotate'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}