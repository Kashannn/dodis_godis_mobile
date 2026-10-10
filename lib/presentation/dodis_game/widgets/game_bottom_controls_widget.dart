import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/services/audio_service.dart';
import 'dice_roller_widget.dart';

class GameBottomControlsWidget extends StatefulWidget {
  final bool isRolling;
  final int diceValue;
  final VoidCallback onRoll;
  final VoidCallback? onChat;
  final VoidCallback? onRules;

  const GameBottomControlsWidget({
    super.key,
    required this.isRolling,
    required this.diceValue,
    required this.onRoll,
    this.onChat,
    this.onRules,
  });

  @override
  State<GameBottomControlsWidget> createState() =>
      _GameBottomControlsWidgetState();
}

class _GameBottomControlsWidgetState extends State<GameBottomControlsWidget>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  late final AnimationController _landController;
  late final Animation<double> _landScaleAnim;
  late final Animation<double> _landWobbleAnim;

  late final AnimationController _sparkleController;
  late final Animation<double> _sparkleProgress;

  @override
  void initState() {
    super.initState();

    // 1. Idle Pulse Animation for the Dice Button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 2. Landing Bounce & Squash Animation
    _landController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _landScaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.82, end: 1.18)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.18, end: 0.94)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.94, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_landController);

    _landWobbleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.15, end: 0.12)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.12, end: -0.06)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.06, end: 0.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_landController);

    // 3. Celebration Sparkles Burst Animation
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _sparkleProgress = CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant GameBottomControlsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Roll started: play audio sound
    if (!oldWidget.isRolling && widget.isRolling) {
      AudioService.instance.playDiceRoll();
      _sparkleController.reset();
    }

    // Roll ended: trigger landing bounce & sparkle burst!
    if (oldWidget.isRolling && !widget.isRolling) {
      _landController.forward(from: 0.0);
      _sparkleController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _landController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isRolling) return;
    AudioService.instance.playDiceRoll();
    widget.onRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Left Secondary Action (Chat / Sound Icon)
          GestureDetector(
            onTap: widget.onChat,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF0288D1),
                  ],
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0288D1).withValues(alpha: 0.35),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ),

          // 2. Center Primary 3D Dice Action Button (With exact Lottie roll, sound, and 3D resin landing)
          GestureDetector(
            onTap: _handleTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _pulseScale,
                _landController,
                _sparkleController,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.isRolling ? 1.0 : _pulseScale.value,
                  child: child,
                );
              },
              child: Container(
                width: 92.w,
                height: 92.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    center: Alignment(0, -0.3),
                    radius: 0.9,
                    colors: [
                      Color(0xFF40C4FF),
                      Color(0xFF0091EA),
                      Color(0xFF01579B),
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 3.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0091EA).withValues(alpha: 0.5),
                      blurRadius: 16.r,
                      spreadRadius: 2.r,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // While Rolling: 3D 60fps Tumbling Dice Lottie
                      if (widget.isRolling)
                        Lottie.asset(
                          kDiceRollLottie,
                          width: 78.w,
                          height: 78.h,
                          fit: BoxFit.contain,
                          repeat: true,
                        )
                      else ...[
                        // Landed State: High-End 3D Isometric Resin Cube with Squash Bounce & Wobble
                        ScaleTransition(
                          scale: _landScaleAnim.value > 0
                              ? _landScaleAnim
                              : const AlwaysStoppedAnimation(1.0),
                          child: Transform.rotate(
                            angle: _landWobbleAnim.value,
                            child: SizedBox(
                              width: 58.w,
                              height: 58.h,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CustomPaint(
                                    painter: Isometric3DDicePainter(
                                      diceValue: widget.diceValue > 0
                                          ? widget.diceValue
                                          : 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Celebration Sparkle Burst Particles on Landing
                        if (_sparkleController.isAnimating)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: SparkleBurstPainter(
                                progress: _sparkleProgress.value,
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Right Secondary Action (Smiley / Rules Icon)
          GestureDetector(
            onTap: widget.onRules,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF0288D1),
                  ],
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0288D1).withValues(alpha: 0.35),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.sentiment_very_satisfied_rounded,
                  color: Colors.white,
                  size: 26.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
