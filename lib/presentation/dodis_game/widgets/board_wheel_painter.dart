import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BoardWheelPainter extends CustomPainter {
  final int activeTile;
  final List<int> playerPositions;

  BoardWheelPainter({
    required this.activeTile,
    required this.playerPositions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.44;
    final hubRadius = size.width * 0.16;

    final ringPaint = Paint()
      ..color = kBoardWood.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(center, outerRadius, ringPaint);

    // Spokes to center (like Image 2 wheel)
    const spokeCount = 6;
    final spokeColors = [
      kCandyBlue,
      kCandyYellow,
      kCandyPink,
      kCandyGreen,
      kCandyOrange,
      kCandyPurple,
    ];

    for (int i = 0; i < spokeCount; i++) {
      final angle = (i * 2 * pi / spokeCount) - (pi / 2);
      final spokePaint = Paint()
        ..color = spokeColors[i].withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final startOffset = Offset(
        center.dx + hubRadius * cos(angle),
        center.dy + hubRadius * sin(angle),
      );
      final endOffset = Offset(
        center.dx + outerRadius * cos(angle),
        center.dy + outerRadius * sin(angle),
      );
      canvas.drawLine(startOffset, endOffset, spokePaint);

      // Pie slice in hub
      final hubSlicePaint = Paint()
        ..color = spokeColors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: hubRadius),
        angle,
        2 * pi / spokeCount,
        true,
        hubSlicePaint,
      );
    }

    // Outer 24 Track Nodes (as shown in Image 2)
    const totalTiles = 24;
    final tilePalette = [
      kCandyPink,
      kCandyYellow,
      kCandyGreen,
      kCandyBlue,
      kCandyPurple,
      kCandyOrange,
    ];

    for (int i = 0; i < totalTiles; i++) {
      final angle = (i * 2 * pi / totalTiles) - (pi / 2);
      final nodePos = Offset(
        center.dx + outerRadius * cos(angle),
        center.dy + outerRadius * sin(angle),
      );

      final isCurrentActive = i == activeTile;
      final nodeColor = tilePalette[i % tilePalette.length];

      // Draw node circle
      final nodePaint = Paint()
        ..color = isCurrentActive ? nodeColor : nodeColor.withValues(alpha: 0.85)
        ..style = PaintingStyle.fill;

      final radius = isCurrentActive ? 14.0 : 10.0;
      canvas.drawCircle(nodePos, radius, nodePaint);

      if (isCurrentActive) {
        // Active pulse border
        final activeRing = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
        canvas.drawCircle(nodePos, radius + 2, activeRing);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardWheelPainter oldDelegate) {
    return oldDelegate.activeTile != activeTile ||
        oldDelegate.playerPositions != playerPositions;
  }
}
