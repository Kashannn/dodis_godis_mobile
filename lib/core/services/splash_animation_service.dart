import 'package:flutter/material.dart';

/// Core service responsible for managing all entrance and floating animations
/// on the Dodis Godis splash screen.
class SplashAnimationService {
  late final AnimationController entranceController;
  late final AnimationController floatController;

  late final Animation<double> logoFade;
  late final Animation<double> logoScale;
  late final Animation<double> contentFade;
  late final Animation<double> gamesScale;

  /// Initializes the controllers and curved animation timelines with the given [vsync].
  void initialize(TickerProvider vsync) {
    // 1. Entrance animation controller (1200ms)
    entranceController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    // 2. Continuous gentle floating animation loop (3000ms)
    floatController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // 3. Staggered Curved Animations
    logoFade = CurvedAnimation(
      parent: entranceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    logoScale = CurvedAnimation(
      parent: entranceController,
      curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
    );

    contentFade = CurvedAnimation(
      parent: entranceController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
    );

    gamesScale = CurvedAnimation(
      parent: entranceController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
    );
  }

  /// Starts the forward entrance animation sequence.
  void startEntrance() {
    entranceController.forward();
  }

  /// Properly disposes of all animation controllers.
  void dispose() {
    entranceController.dispose();
    floatController.dispose();
  }
}
