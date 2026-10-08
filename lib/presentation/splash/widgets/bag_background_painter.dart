import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom painter for the Dodis Godis candy bag background:
/// - Crisp candy-pink wrapper gradient with subtle gloss
/// - Top and bottom crimped foil seal textures
/// - Retail hanging hole punch slot
/// - Central glossy sky-blue candy window
/// - Sweeping vibrant 7-color rainbow streamer
class BagBackgroundPainter extends CustomPainter {
  const BagBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // 1. Overall candy bag pink gradient
    final Rect fullRect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF7B9B), // vibrant pink
          Color(0xFFFF8DA8), // soft candy pink
          Color(0xFFFF7294), // rich strawberry pink
        ],
      ).createShader(fullRect);
    canvas.drawRect(fullRect, bgPaint);

    // 2. Top crimp packaging bar
    _drawTopCrimp(canvas, width, height);

    // 3. Central sky-blue glossy window
    _drawCenterWindow(canvas, width, height);

    // 4. Vibrant diagonal Rainbow Ribbon
    _drawRainbowArc(canvas, width, height);

    // 5. Candy sparkles / stars
    _drawSparkles(canvas, width, height);

    // 6. Bottom crimp bar
    _drawBottomCrimp(canvas, width, height);
  }

  void _drawTopCrimp(Canvas canvas, double width, double height) {
    final crimpHeight = height * 0.08;

    // Vertical ridges on crimp
    final ridgePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const ridgeCount = 48;
    final dx = width / ridgeCount;
    for (int i = 0; i < ridgeCount; i++) {
      final x = i * dx;
      final isLight = i % 2 == 0;
      ridgePaint.color = isLight
          ? Colors.white.withValues(alpha: 0.18)
          : Colors.black.withValues(alpha: 0.08);
      canvas.drawLine(Offset(x, 0), Offset(x, crimpHeight), ridgePaint);
    }

    // Divider line below top crimp
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(0, crimpHeight),
      Offset(width, crimpHeight),
      linePaint,
    );

    // Hanging hole cutout slot (pill shaped)
    final slotWidth = width * 0.22;
    final slotHeight = crimpHeight * 0.32;
    final slotRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(width / 2, crimpHeight * 0.5),
        width: slotWidth,
        height: slotHeight,
      ),
      Radius.circular(slotHeight / 2),
    );

    // Cutout fill (pure white/translucent) with inner shadow effect
    final slotPaint = Paint()
      ..color = const Color(0xFFFFF0F5)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(slotRect, slotPaint);

    final slotBorderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(slotRect, slotBorderPaint);
  }

  void _drawCenterWindow(Canvas canvas, double width, double height) {
    // Large curved soft sky-blue glossy window in the middle
    final topY = height * 0.09;
    final bottomY = height * 0.88;
    final rect = Rect.fromLTRB(width * 0.03, topY, width * 0.97, bottomY);

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(width * 0.14),
    );

    // Sky-blue radial gradient fill
    final windowPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, -0.15),
        radius: 0.85,
        colors: [
          Color(0xFFFFFFFF), // glowing white center
          Color(0xFFE8F4FD), // soft baby blue
          Color(0xFFCCE7FC), // candy sky blue
          Color(0xFFB5DCFB), // blue margin
        ],
        stops: [0.0, 0.45, 0.8, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, windowPaint);

    // Glossy border highlight
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, borderPaint);
  }

  void _drawRainbowArc(Canvas canvas, double width, double height) {
    // 7-color vibrant rainbow band crossing diagonally
    final colors = [
      const Color(0xFFFF2A42), // Red
      const Color(0xFFFF851B), // Orange
      const Color(0xFFFFDC00), // Yellow
      const Color(0xFF2ECC40), // Green
      const Color(0xFF00C7FF), // Cyan
      const Color(0xFF0074D9), // Blue
      const Color(0xFFB10DC9), // Purple
    ];

    final strokeW = width * 0.022;

    // We draw parallel curved bands
    for (int i = 0; i < colors.length; i++) {
      final paint = Paint()
        ..color = colors[i].withValues(alpha: 0.85)
        ..strokeWidth = strokeW
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path();
      // Curved path sweeping from bottom-left towards upper-right
      final offsetMultiplier = (i - 3) * strokeW;

      final startX = -width * 0.05;
      final startY = height * 0.82 + offsetMultiplier;

      final cp1X = width * 0.28;
      final cp1Y = height * 0.65 + offsetMultiplier;

      final cp2X = width * 0.60;
      final cp2Y = height * 0.48 + offsetMultiplier;

      final endX = width * 1.05;
      final endY = height * 0.38 + offsetMultiplier;

      path.moveTo(startX, startY);
      path.cubicTo(cp1X, cp1Y, cp2X, cp2Y, endX, endY);

      canvas.drawPath(path, paint);
    }
  }

  void _drawSparkles(Canvas canvas, double width, double height) {
    final sparklePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;

    // Small star sparkles at specific coordinates
    final sparklePoints = [
      Offset(width * 0.18, height * 0.24),
      Offset(width * 0.82, height * 0.20),
      Offset(width * 0.52, height * 0.46),
      Offset(width * 0.12, height * 0.62),
      Offset(width * 0.88, height * 0.72),
    ];

    for (final pt in sparklePoints) {
      _draw4PointStar(canvas, pt, width * 0.018, sparklePaint);
    }
  }

  void _draw4PointStar(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final r = (i % 2 == 0) ? radius : radius * 0.3;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawBottomCrimp(Canvas canvas, double width, double height) {
    final crimpTop = height * 0.94;

    final ridgePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const ridgeCount = 48;
    final dx = width / ridgeCount;
    for (int i = 0; i < ridgeCount; i++) {
      final x = i * dx;
      final isLight = i % 2 == 0;
      ridgePaint.color = isLight
          ? Colors.white.withValues(alpha: 0.18)
          : Colors.black.withValues(alpha: 0.08);
      canvas.drawLine(Offset(x, crimpTop), Offset(x, height), ridgePaint);
    }

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(0, crimpTop), Offset(width, crimpTop), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
