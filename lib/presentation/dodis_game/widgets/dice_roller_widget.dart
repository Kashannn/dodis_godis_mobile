import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/services/audio_service.dart';

class DiceRollerWidget extends StatefulWidget {
  final int diceValue;
  final bool isRolling;
  final VoidCallback onRoll;

  const DiceRollerWidget({
    super.key,
    required this.diceValue,
    required this.isRolling,
    required this.onRoll,
  });

  @override
  State<DiceRollerWidget> createState() => _DiceRollerWidgetState();
}

class _DiceRollerWidgetState extends State<DiceRollerWidget>
    with TickerProviderStateMixin {
  late final AnimationController _landController;
  late final Animation<double> _landScaleAnim;
  late final Animation<double> _landWobbleAnim;

  late final AnimationController _sparkleController;
  late final Animation<double> _sparkleProgress;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();

    // 1. Landing bounce & squash animation
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

    // 2. Celebration sparkle particles controller
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _sparkleProgress = CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeOutCubic,
    );

    // 3. Ambient idle pulse controller for rolling stage
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void didUpdateWidget(covariant DiceRollerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Roll started
    if (!oldWidget.isRolling && widget.isRolling) {
      AudioService.instance.playDiceRoll();
      _sparkleController.reset();
    }

    // Roll ended: Dice landed!
    if (oldWidget.isRolling && !widget.isRolling) {
      _landController.forward(from: 0.0);
      _sparkleController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _landController.dispose();
    _sparkleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isRolling) return;
    AudioService.instance.playDiceRoll();
    widget.onRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Casino Felt Rolling Arena Tray
        GestureDetector(
          onTap: _handleTap,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _landController,
              _sparkleController,
              _pulseController,
            ]),
            builder: (context, _) {
              final isRolling = widget.isRolling;

              return ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Arena Felt Pattern / Ambient Radial Glow
                    Positioned(
                      bottom: 12.h,
                      child: Container(
                        width: 140.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(140.w, 30.h),
                          ),
                          gradient: RadialGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // When Rolling: Full 3D 60fps Tumbling Dice Lottie
                    if (isRolling) ...[
                      ScaleTransition(
                        scale: _pulseScale,
                        child: Lottie.asset(
                          kDiceRollLottie,
                          width: 175.w,
                          height: 175.w,
                          fit: BoxFit.contain,
                          repeat: true,
                        ),
                      ),
                    ] else ...[
                      // Landed State: High-End 3D Isometric Resin Cube
                      ScaleTransition(
                        scale: _landScaleAnim.value > 0
                            ? _landScaleAnim
                            : const AlwaysStoppedAnimation(1.0),
                        child: Transform.rotate(
                          angle: _landWobbleAnim.value,
                          child: SizedBox(
                            width: 150.w,
                            height: 150.w,
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

                      // Celebration Sparkle Burst Particles
                      if (_sparkleController.isAnimating) ...[
                        Positioned.fill(
                          child: CustomPaint(
                            painter: SparkleBurstPainter(
                              progress: _sparkleProgress.value,
                            ),
                          ),
                        ),
                      ],
                    ],


                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(height: 14.h),

        // 2. High-Impact Roll Button
        ElevatedButton(
          onPressed: widget.isRolling ? null : _handleTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: kCandyRed,
            foregroundColor: kWhite,
            disabledBackgroundColor: kCandyRed.withValues(alpha: 0.6),
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
            elevation: widget.isRolling ? 1 : 6,
            shadowColor: kCandyRed.withValues(alpha: 0.45),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isRolling
                    ? Icons.hourglass_top_rounded
                    : Icons.casino_rounded,
                color: kWhite,
                size: 21.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                widget.isRolling
                    ? kRollingDice
                    : (widget.diceValue > 0
                        ? kRollAgainAction
                        : kRollDiceAction),
                style: kButtonMediumStyle.copyWith(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom Painter that renders an authentic 3D Isometric Resin Dice Cube
class Isometric3DDicePainter extends CustomPainter {
  final int diceValue;

  Isometric3DDicePainter({required this.diceValue});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 2;

    // Geometric constants for isometric projection
    const hw = 44.0; // half-width of cube
    const th = 26.0; // top face height tilt
    const ch = 48.0; // cube column height

    // 1. Soft Contact Shadow under cube
    final shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withValues(alpha: 0.28),
          Colors.black.withValues(alpha: 0.10),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
        Rect.fromCenter(
          center: Offset(cx, cy + ch + 8),
          width: hw * 2.5,
          height: 28,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + ch + 8),
        width: hw * 2.5,
        height: 28,
      ),
      shadowPaint,
    );

    // 2. Front-Left Face (Mid-tone Shade)
    final leftFacePath = Path()
      ..moveTo(cx - hw, cy - th + 2)
      ..lineTo(cx, cy + 2)
      ..lineTo(cx, cy + ch)
      ..lineTo(cx - hw, cy - th + ch)
      ..close();

    final leftFacePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF1F3F9),
          Color(0xFFDEE3EF),
          Color(0xFFCFD5E5),
        ],
      ).createShader(leftFacePath.getBounds());

    final bevelStrokePaint = Paint()
      ..color = const Color(0xFFBEC7DC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(leftFacePath, leftFacePaint);
    canvas.drawPath(leftFacePath, bevelStrokePaint);

    // 3. Front-Right Face (Darker Shadow)
    final rightFacePath = Path()
      ..moveTo(cx, cy + 2)
      ..lineTo(cx + hw, cy - th + 2)
      ..lineTo(cx + hw, cy - th + ch)
      ..lineTo(cx, cy + ch)
      ..close();

    final rightFacePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFFE4E8F4),
          Color(0xFFD2D8E8),
          Color(0xFFC0C7DC),
        ],
      ).createShader(rightFacePath.getBounds());

    canvas.drawPath(rightFacePath, rightFacePaint);
    canvas.drawPath(rightFacePath, bevelStrokePaint);

    // 4. Top Face (Highlight Porcelain Surface)
    final topFacePath = Path()
      ..moveTo(cx, cy - th * 2)
      ..lineTo(cx + hw, cy - th)
      ..lineTo(cx, cy)
      ..lineTo(cx - hw, cy - th)
      ..close();

    final topFacePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFFCFDFE),
          Color(0xFFF2F5FB),
        ],
      ).createShader(topFacePath.getBounds());

    final topStrokePaint = Paint()
      ..color = const Color(0xFFD8DFEF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(topFacePath, topFacePaint);
    canvas.drawPath(topFacePath, topStrokePaint);

    // Specular diagonal gleam on top face
    final sheenPath = Path()
      ..moveTo(cx - 15, cy - th * 2 + 8)
      ..lineTo(cx + hw - 10, cy - th - 3)
      ..lineTo(cx + hw - 18, cy - th + 2)
      ..lineTo(cx - 23, cy - th * 2 + 13)
      ..close();

    final sheenPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawPath(sheenPath, sheenPaint);

    // 5. Draw 3D Embossed Candy Red Pips onto the Top Face
    _drawIsometricPips(canvas, cx, cy - th, diceValue);
  }

  void _drawIsometricPips(Canvas canvas, double cx, double cy, int value) {
    final effectiveValue = value <= 0 ? 1 : (value > 6 ? 6 : value);

    // Local coordinates in normalized [-1, 1] isometric space
    final pipsCoords = <int, List<Offset>>{
      1: [const Offset(0, 0)],
      2: [const Offset(-0.48, -0.48), const Offset(0.48, 0.48)],
      3: [
        const Offset(-0.52, -0.52),
        const Offset(0, 0),
        const Offset(0.52, 0.52)
      ],
      4: [
        const Offset(-0.48, -0.48),
        const Offset(0.48, -0.48),
        const Offset(-0.48, 0.48),
        const Offset(0.48, 0.48),
      ],
      5: [
        const Offset(-0.52, -0.52),
        const Offset(0.52, -0.52),
        const Offset(0, 0),
        const Offset(-0.52, 0.52),
        const Offset(0.52, 0.52),
      ],
      6: [
        const Offset(-0.52, -0.55),
        const Offset(-0.52, 0),
        const Offset(-0.52, 0.55),
        const Offset(0.52, -0.55),
        const Offset(0.52, 0),
        const Offset(0.52, 0.55),
      ],
    }[effectiveValue] ?? [const Offset(0, 0)];

    for (final coord in pipsCoords) {
      // Map isometric local coords:
      // U axis is along (hw/2, th/2), V axis is along (-hw/2, th/2)
      const uFactorX = 36.0;
      const uFactorY = 19.0;
      const vFactorX = -36.0;
      const vFactorY = 19.0;

      final px = cx + coord.dx * uFactorX + coord.dy * vFactorX;
      final py = cy + coord.dx * uFactorY + coord.dy * vFactorY;

      final isAce = effectiveValue == 1;
      final radX = isAce ? 9.5 : 6.8;
      final radY = isAce ? 5.8 : 4.0;

      final pipRect = Rect.fromCenter(
        center: Offset(px, py),
        width: radX * 2,
        height: radY * 2,
      );

      // Deep pip inner drop shadow
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(px, py + 1.2),
          width: radX * 2,
          height: radY * 2,
        ),
        Paint()..color = const Color(0xFF8B0014),
      );

      // Cherry Candy Red Pip Body
      final pipPaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.25, -0.3),
          radius: 0.85,
          colors: [
            Color(0xFFFF334B),
            Color(0xFFE50926),
            Color(0xFFB30018),
          ],
        ).createShader(pipRect);

      canvas.drawOval(pipRect, pipPaint);

      // Specular Shine Reflection Dot
      final shineRect = Rect.fromCenter(
        center: Offset(px - radX * 0.32, py - radY * 0.32),
        width: radX * 0.7,
        height: radY * 0.65,
      );
      canvas.drawOval(
        shineRect,
        Paint()..color = const Color(0xFFFFB3BC).withValues(alpha: 0.9),
      );
    }
  }

  @override
  bool shouldRepaint(covariant Isometric3DDicePainter oldDelegate) {
    return oldDelegate.diceValue != diceValue;
  }
}

/// Celebration Sparkle Burst Painter when dice lands
class SparkleBurstPainter extends CustomPainter {
  final double progress;

  SparkleBurstPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;

    final cx = size.width / 2;
    final cy = size.height / 2;

    const numSparkles = 8;
    const colors = [
      Color(0xFFFFD166), // Gold
      Color(0xFFFF2A42), // Red
      Color(0xFF06D6A0), // Emerald
      Color(0xFF118AB2), // Blue
      Color(0xFFFF85A1), // Pink
      Color(0xFFFFD166), // Gold
      Color(0xFFFF2A42), // Red
      Color(0xFF06D6A0), // Emerald
    ];

    for (int i = 0; i < numSparkles; i++) {
      final angle = (i * 2 * math.pi / numSparkles) + (progress * 0.4);
      final dist = (35.0 + (progress * 48.0));
      final x = cx + math.cos(angle) * dist;
      final y = cy + math.sin(angle) * dist;

      final alpha = (1.0 - progress).clamp(0.0, 1.0);
      final radius = ((1.0 - (progress - 0.5).abs() * 2) * 5.0).clamp(1.0, 6.0);

      final paint = Paint()
        ..color = colors[i % colors.length].withValues(alpha: alpha)
        ..style = PaintingStyle.fill;

      // Draw diamond sparkle star
      final path = Path()
        ..moveTo(x, y - radius * 1.5)
        ..lineTo(x + radius, y)
        ..lineTo(x, y + radius * 1.5)
        ..lineTo(x - radius, y)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SparkleBurstPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

