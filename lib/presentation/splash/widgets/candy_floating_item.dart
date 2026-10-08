import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated floating wrapper for modular candy and game assets on the splash screen.
/// Provides subtle bobbing, rotation wobble, and smooth shadows.
class CandyFloatingItem extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double floatDelta; // in pixels
  final double rotationDelta; // in radians
  final double phaseOffset; // 0.0 to 1.0 phase offset

  const CandyFloatingItem({
    super.key,
    required this.child,
    required this.animation,
    this.floatDelta = 6.0,
    this.rotationDelta = 0.04,
    this.phaseOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = (animation.value + phaseOffset) % 1.0;
        final floatY = math.sin(progress * 2 * math.pi) * floatDelta;
        final rot = math.cos(progress * 2 * math.pi) * rotationDelta;

        return Transform.translate(
          offset: Offset(0, floatY),
          child: Transform.rotate(
            angle: rot,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
