import 'dart:math';
import 'package:flutter/material.dart';

import '../../../data/models/board_tile_model.dart';
import '../bloc/dodis_game_state.dart';

class BoardWheelPainter extends CustomPainter {
  final int activeTile;
  final List<GamePlayer> players;
  final int currentPlayerIndex;
  final List<BoardTileModel> boardTiles;

  BoardWheelPainter({
    required this.activeTile,
    required this.players,
    required this.currentPlayerIndex,
    List<BoardTileModel>? boardTiles,
  }) : boardTiles = (boardTiles != null && boardTiles.isNotEmpty)
            ? boardTiles
            : BoardTileModel.defaultBoardTiles();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final boardRadius = size.width * 0.48;
    final trackRadius = size.width * 0.40;
    final innerBeadRadius = size.width * 0.28;
    final wheelRadius = size.width * 0.21;
    final hubRadius = size.width * 0.055;

    // 1. Warm Soft Cream Board Base
    final boardBasePaint = Paint()
      ..color = const Color(0xFFFFFDF7)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, boardRadius, boardBasePaint);

    final boardShadowPaint = Paint()
      ..color = const Color(0xFFD4A373).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    canvas.drawCircle(center, boardRadius - 3, boardShadowPaint);

    // 2. Connecting Track Rings (Double circular guide)
    final trackPathPaint = Paint()
      ..color = const Color(0xFFE9C46A).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(center, trackRadius, trackPathPaint);

    // 3. Inner Candy Bead Ring (decorative circle between track and wheel)
    const beadCount = 20;
    for (int i = 0; i < beadCount; i++) {
      final angle = (i * 2 * pi / beadCount) - (pi / 2);
      final beadPos = Offset(
        center.dx + innerBeadRadius * cos(angle),
        center.dy + innerBeadRadius * sin(angle),
      );
      final beadColors = [
        const Color(0xFF81C784),
        const Color(0xFFFFD54F),
        const Color(0xFFFF8A80),
        const Color(0xFFBA68C8),
        const Color(0xFF4FC3F7),
      ];
      final beadPaint = Paint()
        ..color = beadColors[i % beadColors.length].withValues(alpha: 0.75)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(beadPos, 4.5, beadPaint);
    }

    // 4. Central Trivial Pursuit Compatible Wheel (6 wedges matching sketch)
    const wedgeCount = 6;
    final wedgeColors = [
      const Color(0xFF1E88E5), // Blue (Geography)
      const Color(0xFFFBC02D), // Yellow (History)
      const Color(0xFF43A047), // Green (Science & Nature)
      const Color(0xFFFB8C00), // Orange (Sports & Leisure)
      const Color(0xFFE53935), // Red / Pink (Wildcard / General)
      const Color(0xFF8E24AA), // Purple (Arts & Entertainment)
    ];

    for (int i = 0; i < wedgeCount; i++) {
      final startAngle = (i * 2 * pi / wedgeCount) - (pi / 2);
      final sweepAngle = 2 * pi / wedgeCount;

      final wedgePaint = Paint()
        ..color = wedgeColors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: wheelRadius),
        startAngle,
        sweepAngle,
        true,
        wedgePaint,
      );

      // Wedge divider line
      final dividerPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      final lineEnd = Offset(
        center.dx + wheelRadius * cos(startAngle),
        center.dy + wheelRadius * sin(startAngle),
      );
      canvas.drawLine(center, lineEnd, dividerPaint);
    }

    // 4b. 6 Spoke Connecting Tracks Radiating Outwards to the 6 Hubs (from client sketch)
    for (int s = 0; s < 6; s++) {
      final spokeAngle = (s * 2 * pi / 6) - (pi / 2);
      final spokeStart = Offset(
        center.dx + wheelRadius * cos(spokeAngle),
        center.dy + wheelRadius * sin(spokeAngle),
      );
      final spokeEnd = Offset(
        center.dx + (trackRadius - 16) * cos(spokeAngle),
        center.dy + (trackRadius - 16) * sin(spokeAngle),
      );

      // Track spoke line
      final spokePaint = Paint()
        ..color = const Color(0xFFD7CCC8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5;
      canvas.drawLine(spokeStart, spokeEnd, spokePaint);

      // Intermediate small candy spots along each spoke (like in sketch)
      for (double t = 0.35; t <= 0.75; t += 0.35) {
        final circlePos = Offset.lerp(spokeStart, spokeEnd, t)!;
        final spokeCircleBg = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        final spokeCircleBorder = Paint()
          ..color = const Color(0xFFBCAAA4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawCircle(circlePos, 5.0, spokeCircleBg);
        canvas.drawCircle(circlePos, 5.0, spokeCircleBorder);
      }
    }

    // Golden wheel border
    final wheelRimPaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;
    canvas.drawCircle(center, wheelRadius, wheelRimPaint);

    final wheelRimInner = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, wheelRadius - 2, wheelRimInner);

    // Wheel Center Hub with Arrow / Candy Cane
    final hubShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + const Offset(0, 2), hubRadius, hubShadowPaint);

    final hubPaint = Paint()
      ..color = const Color(0xFF29B6F6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, hubRadius, hubPaint);

    final hubBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, hubRadius, hubBorder);

    // Little center spinner pointer
    final arrowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(center.dx, center.dy - hubRadius - 6)
      ..lineTo(center.dx - 4, center.dy - hubRadius + 2)
      ..lineTo(center.dx + 4, center.dy - hubRadius + 2)
      ..close();
    canvas.drawPath(arrowPath, arrowPaint);

    // 5. Outer 24 Track Nodes (Matching Physical Board Layout)
    final totalTiles = boardTiles.length;

    for (int i = 0; i < totalTiles; i++) {
      final tile = boardTiles[i];
      final angle = (i * 2 * pi / totalTiles) - (pi / 2);
      final nodePos = Offset(
        center.dx + trackRadius * cos(angle),
        center.dy + trackRadius * sin(angle),
      );

      final isCurrentActive = i == activeTile;

      // Draw the tile according to its designated type
      switch (tile.type) {
        case BoardTileType.blankCandy:
          _drawBlankCandyTile(canvas, nodePos, tile);
          break;
        case BoardTileType.challenge:
          _drawChallengeTile(canvas, nodePos, tile);
          break;
        case BoardTileType.kastaOm:
          _drawKastaOmTile(canvas, nodePos, tile);
          break;
        case BoardTileType.stationHub:
          _drawStationHubTile(canvas, nodePos, tile);
          break;
      }

      // Active Tile Highlight Glow
      if (isCurrentActive) {
        final activeRing = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5;
        canvas.drawCircle(nodePos, 21.5, activeRing);

        final activeGlow = Paint()
          ..color = const Color(0xFFFFD700).withValues(alpha: 0.65)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;
        canvas.drawCircle(nodePos, 24.5, activeGlow);
      }
    }

    // 6. Draw 3D Player Pawns on their tiles!
    // Group players by currentTile to handle multiple pawns on the same tile
    final Map<int, List<int>> tileToPlayerIndices = {};
    for (int pIdx = 0; pIdx < players.length; pIdx++) {
      final tile = players[pIdx].currentTile % totalTiles;
      tileToPlayerIndices.putIfAbsent(tile, () => []).add(pIdx);
    }

    const defaultPawnColors = [
      Color(0xFFFF5252), // Red
      Color(0xFFFFD54F), // Yellow
      Color(0xFF66BB6A), // Green
      Color(0xFF42A5F5), // Blue
      Color(0xFFFFA726), // Orange
      Color(0xFFAB47BC), // Purple
    ];

    tileToPlayerIndices.forEach((tile, playerIndices) {
      final angle = (tile * 2 * pi / totalTiles) - (pi / 2);
      final nodePos = Offset(
        center.dx + trackRadius * cos(angle),
        center.dy + trackRadius * sin(angle),
      );

      for (int i = 0; i < playerIndices.length; i++) {
        final pIdx = playerIndices[i];
        final player = players[pIdx];
        final isTurn = pIdx == currentPlayerIndex;

        // Calculate offset if multiple players share a tile
        Offset pawnPos = nodePos;
        if (playerIndices.length > 1) {
          final count = playerIndices.length;
          final spreadAngle = (i - (count - 1) / 2) * (pi / 4);
          pawnPos = nodePos + Offset(8 * sin(spreadAngle), 8 * cos(spreadAngle));
        }

        final pawnColor = player.holderColor ??
            defaultPawnColors[player.avatarIndex % defaultPawnColors.length];

        _draw3DPawn(canvas, pawnPos, pawnColor, isTurn);
      }
    });

    // 7. Corner Games & Zones (Matching Hand-Drawn Printable Sketch)
    _drawNoughtsAndCrossesCorner(canvas, size);
    _drawStartZoneCorner(canvas, size);
  }

  /// 1. Blank circular plate where candy from the bag is placed
  void _drawBlankCandyTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const plateRadius = 16.0;

    // Indented plate shadow
    final plateShadow = Paint()
      ..color = const Color(0xFF8D6E63).withValues(alpha: 0.16)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(pos + const Offset(0, 1.5), plateRadius, plateShadow);

    // Plate ceramic/groove base
    final platePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        radius: 0.9,
        colors: const [
          Color(0xFFFFFDF8),
          Color(0xFFF3ECE0),
          Color(0xFFE4D7C2),
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: pos, radius: plateRadius));
    canvas.drawCircle(pos, plateRadius, platePaint);

    final plateRim = Paint()
      ..color = const Color(0xFFD7CCC8).withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(pos, plateRadius, plateRim);

    // If candy piece is present, draw the glossy 3D candy marker!
    if (tile.hasCandy) {
      const candyRadius = 11.5;
      final candyShadow = Paint()
        ..color = tile.baseColor.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);
      canvas.drawCircle(pos + const Offset(0, 2), candyRadius, candyShadow);

      final candyPaint = Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.35),
          radius: 0.85,
          colors: [
            Colors.white.withValues(alpha: 0.8),
            tile.baseColor,
            Color.lerp(tile.baseColor, Colors.black, 0.28)!,
          ],
          stops: const [0.0, 0.35, 1.0],
        ).createShader(Rect.fromCircle(center: pos, radius: candyRadius));
      canvas.drawCircle(pos, candyRadius, candyPaint);

      // Candy border
      final candyRim = Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawCircle(pos, candyRadius, candyRim);

      // Candy gloss glint
      final glint = Paint()
        ..color = Colors.white.withValues(alpha: 0.9)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos + const Offset(-3, -3), 2.2, glint);
    } else {
      // Empty Plate: Subtle dotted inner ring showing candy was collected
      final emptyRing = Paint()
        ..color = const Color(0xFFBCAAA4).withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(pos, 8.5, emptyRing);
    }
  }

  /// 2. Illustrated Challenge Badge (Utmaning)
  void _drawChallengeTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 18.5;

    final shadowPaint = Paint()
      ..color = tile.baseColor.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);
    canvas.drawCircle(pos + const Offset(0, 2), radius, shadowPaint);

    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 0.85,
        colors: [
          Color.lerp(tile.baseColor, Colors.white, 0.35)!,
          tile.baseColor,
          Color.lerp(tile.baseColor, Colors.black, 0.22)!,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: pos, radius: radius));
    canvas.drawCircle(pos, radius, bgPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawCircle(pos, radius, borderPaint);

    // Challenge icon glyph matching Swedish gameboard drawing
    final symbol = _getChallengeSymbol(tile.challenge?.id ?? '');
    _drawCenteredText(canvas, pos, symbol, 14.5);
  }

  /// 3. Kasta Om (Reroll Extra Turn)
  void _drawKastaOmTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 17.5;

    final shadowPaint = Paint()
      ..color = const Color(0xFFFF5722).withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);
    canvas.drawCircle(pos + const Offset(0, 2), radius, shadowPaint);

    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 0.85,
        colors: const [
          Color(0xFFFFD180),
          Color(0xFFFF9100),
          Color(0xFFDD2C00),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: pos, radius: radius));
    canvas.drawCircle(pos, radius, bgPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawCircle(pos, radius, borderPaint);

    _drawCenteredText(canvas, pos, '🎲', 14.5);
  }

  /// 4. Station Hub (Holder Cup station)
  void _drawStationHubTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 20.5;

    final shadowPaint = Paint()
      ..color = tile.baseColor.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.5);
    canvas.drawCircle(pos + const Offset(0, 2.5), radius, shadowPaint);

    // Outer golden station rim
    final goldRim = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, radius, goldRim);

    // Inner player hub disc
    final innerPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 0.85,
        colors: [
          Color.lerp(tile.baseColor, Colors.white, 0.4)!,
          tile.baseColor,
          Color.lerp(tile.baseColor, Colors.black, 0.28)!,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: pos, radius: radius - 2.5));
    canvas.drawCircle(pos, radius - 2.5, innerPaint);

    final innerBorder = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(pos, radius - 2.5, innerBorder);

    _drawCenteredText(canvas, pos, '🌟', 15.0);
  }

  String _getChallengeSymbol(String id) {
    switch (id) {
      case 'bygga_torn':
        return '🧱';
      case 'sten_sax_pase':
        return '✂️';
      case 'sant_falskt':
        return '❓';
      case 'singla_slant':
        return '🪙';
      case 'gissa_hand':
        return '✋';
      case 'supersur':
        return '🍋';
      case 'fanga_godis':
        return '🎯';
      case 'ata_snore':
        return '🍬';
      case 'snurra_klubba':
        return '🍭';
      case 'sanning_konsekvens':
        return '🎭';
      case 'lukttest':
        return '👃';
      case 'smakprov':
        return '👅';
      default:
        return '⚡';
    }
  }

  void _drawCenteredText(
    Canvas canvas,
    Offset center,
    String text,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  /// Draws a classic 3D sculpted board game pawn pin
  void _draw3DPawn(
    Canvas canvas,
    Offset pos,
    Color color,
    bool isTurnPlayer,
  ) {
    final lightColor = Color.lerp(color, Colors.white, 0.45)!;
    final darkColor = Color.lerp(color, Colors.black, 0.35)!;

    // Ground Drop Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawOval(
      Rect.fromCenter(
        center: pos + const Offset(1, 14),
        width: 18,
        height: 7,
      ),
      shadowPaint,
    );

    // Active glow halo at the base if it's the current player's turn
    if (isTurnPlayer) {
      final haloPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4;
      canvas.drawCircle(pos + const Offset(0, 11), 11, haloPaint);

      final outerGlow = Paint()
        ..color = const Color(0xFFFFD54F).withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;
      canvas.drawCircle(pos + const Offset(0, 11), 13.5, outerGlow);
    }

    // 1. Pedestal Base (Wide Flared Disc)
    final baseRect = Rect.fromCenter(
      center: pos + const Offset(0, 11),
      width: 17,
      height: 7,
    );
    final basePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lightColor, color, darkColor],
      ).createShader(baseRect);
    canvas.drawOval(baseRect, basePaint);

    final baseRim = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawOval(baseRect, baseRim);

    // 2. Conical Body / Sleek Stem
    final bodyPath = Path()
      ..moveTo(pos.dx - 6, pos.dy + 10)
      ..quadraticBezierTo(
        pos.dx - 2.5,
        pos.dy + 2,
        pos.dx - 3.5,
        pos.dy - 3,
      )
      ..lineTo(pos.dx + 3.5, pos.dy - 3)
      ..quadraticBezierTo(
        pos.dx + 2.5,
        pos.dy + 2,
        pos.dx + 6,
        pos.dy + 10,
      )
      ..close();

    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lightColor, color, darkColor],
      ).createShader(Rect.fromCenter(center: pos, width: 14, height: 16));
    canvas.drawPath(bodyPath, bodyPaint);

    // 3. Spherical Head (Round 3D Ball)
    final headCenter = pos + const Offset(0, -6.5);
    const headRadius = 6.5;

    final headPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.35, -0.35),
        radius: 0.85,
        colors: [
          Colors.white.withValues(alpha: 0.9),
          lightColor,
          color,
          darkColor,
        ],
        stops: const [0.0, 0.25, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: headCenter, radius: headRadius));
    canvas.drawCircle(headCenter, headRadius, headPaint);

    // Specular Highlight Glint on Head
    final glintPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(headCenter + const Offset(-2, -2.5), 1.6, glintPaint);
  }

  /// Corner 1 (Top-Right): Noughts & Crosses (Tic-Tac-Toe / Luffarschack) from printable sketch
  void _drawNoughtsAndCrossesCorner(Canvas canvas, Size size) {
    if (size.width < 180) return;
    final boxSize = (size.width * 0.155).clamp(38.0, 56.0);
    final cornerRect = Rect.fromLTWH(
      size.width - boxSize - 6,
      6,
      boxSize,
      boxSize,
    );

    // Background tile
    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = const Color(0xFF8D6E63)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final rrect = RRect.fromRectAndRadius(cornerRect, const Radius.circular(8));
    canvas.drawRRect(rrect, bgPaint);
    canvas.drawRRect(rrect, borderPaint);

    // 3x3 Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFF8D6E63).withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final step = boxSize / 3;
    // Vertical lines
    canvas.drawLine(
      Offset(cornerRect.left + step, cornerRect.top + 3),
      Offset(cornerRect.left + step, cornerRect.bottom - 3),
      gridPaint,
    );
    canvas.drawLine(
      Offset(cornerRect.left + step * 2, cornerRect.top + 3),
      Offset(cornerRect.left + step * 2, cornerRect.bottom - 3),
      gridPaint,
    );
    // Horizontal lines
    canvas.drawLine(
      Offset(cornerRect.left + 3, cornerRect.top + step),
      Offset(cornerRect.right - 3, cornerRect.top + step),
      gridPaint,
    );
    canvas.drawLine(
      Offset(cornerRect.left + 3, cornerRect.top + step * 2),
      Offset(cornerRect.right - 3, cornerRect.top + step * 2),
      gridPaint,
    );

    // Miniature candy chips X & O in the grid
    final xPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    final oPaint = Paint()
      ..color = const Color(0xFFFBC02D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    // Center cell has O
    canvas.drawCircle(
      Offset(cornerRect.left + step * 1.5, cornerRect.top + step * 1.5),
      step * 0.28,
      oPaint,
    );

    // Top-left cell has X
    final xHalf = step * 0.24;
    final cX = cornerRect.left + step * 0.5;
    final cY = cornerRect.top + step * 0.5;
    canvas.drawLine(Offset(cX - xHalf, cY - xHalf), Offset(cX + xHalf, cY + xHalf), xPaint);
    canvas.drawLine(Offset(cX + xHalf, cY - xHalf), Offset(cX - xHalf, cY + xHalf), xPaint);

    // Small arrow pointing toward the board track
    final arrowPaint = Paint()
      ..color = const Color(0xFF8D6E63)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(cornerRect.left - 2, cornerRect.bottom - 4),
      Offset(cornerRect.left - 9, cornerRect.bottom + 4),
      arrowPaint,
    );
  }

  /// Corner 2 (Bottom-Left): START FÄLT (Start Zone with 4 player color tokens) from printable sketch
  void _drawStartZoneCorner(Canvas canvas, Size size) {
    if (size.width < 180) return;
    final boxSize = (size.width * 0.155).clamp(38.0, 56.0);
    final cornerRect = Rect.fromLTWH(
      6,
      size.height - boxSize - 6,
      boxSize,
      boxSize,
    );

    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = const Color(0xFF388E3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final rrect = RRect.fromRectAndRadius(cornerRect, const Radius.circular(8));
    canvas.drawRRect(rrect, bgPaint);
    canvas.drawRRect(rrect, borderPaint);

    // 4 Player colored holder circles (2x2)
    final tokenColors = [
      const Color(0xFF1E88E5), // Blue
      const Color(0xFFE53935), // Red
      const Color(0xFF43A047), // Green
      const Color(0xFFFBC02D), // Yellow
    ];
    final tokenRadius = boxSize * 0.15;
    final stepX = boxSize * 0.35;
    final stepY = boxSize * 0.35;
    final startX = cornerRect.left + boxSize * 0.32;
    final startY = cornerRect.top + boxSize * 0.32;

    for (int t = 0; t < 4; t++) {
      final col = t % 2;
      final row = t ~/ 2;
      final pos = Offset(startX + col * stepX, startY + row * stepY);
      final tPaint = Paint()
        ..color = tokenColors[t]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, tokenRadius, tPaint);
    }

    // Small arrow pointing into the board
    final arrowPaint = Paint()
      ..color = const Color(0xFF388E3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(cornerRect.right + 2, cornerRect.top - 2),
      Offset(cornerRect.right + 8, cornerRect.top - 8),
      arrowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant BoardWheelPainter oldDelegate) {
    return oldDelegate.activeTile != activeTile ||
        oldDelegate.currentPlayerIndex != currentPlayerIndex ||
        oldDelegate.players != players ||
        oldDelegate.boardTiles != boardTiles;
  }
}
