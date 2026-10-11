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

    // 4. Central Rainbow Spinner Wheel (8 wedges)
    const wedgeCount = 8;
    final wedgeColors = [
      const Color(0xFF42A5F5), // Blue
      const Color(0xFFFFEE58), // Yellow
      const Color(0xFF66BB6A), // Green
      const Color(0xFFFFA726), // Orange
      const Color(0xFFEF5350), // Red
      const Color(0xFFEC407A), // Pink
      const Color(0xFFAB47BC), // Purple
      const Color(0xFF26C6DA), // Cyan
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
        ..color = Colors.white.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      final lineEnd = Offset(
        center.dx + wheelRadius * cos(startAngle),
        center.dy + wheelRadius * sin(startAngle),
      );
      canvas.drawLine(center, lineEnd, dividerPaint);
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
          ..strokeWidth = 3.2;
        canvas.drawCircle(nodePos, 19.5, activeRing);

        final activeGlow = Paint()
          ..color = const Color(0xFFFFD700).withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
        canvas.drawCircle(nodePos, 22.0, activeGlow);
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
  }

  /// 1. Blank circular plate where candy from the bag is placed
  void _drawBlankCandyTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const plateRadius = 14.5;

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
      ..strokeWidth = 1.3;
    canvas.drawCircle(pos, plateRadius, plateRim);

    // If candy piece is present, draw the glossy 3D candy marker!
    if (tile.hasCandy) {
      const candyRadius = 10.5;
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
      canvas.drawCircle(pos + const Offset(-3, -3), 2.0, glint);
    } else {
      // Empty Plate: Subtle dotted inner ring showing candy was collected
      final emptyRing = Paint()
        ..color = const Color(0xFFBCAAA4).withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(pos, 7.5, emptyRing);
    }
  }

  /// 2. Illustrated Challenge Badge (Utmaning)
  void _drawChallengeTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 16.0;

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
      ..strokeWidth = 2.0;
    canvas.drawCircle(pos, radius, borderPaint);

    // Challenge icon glyph matching Swedish gameboard drawing
    final symbol = _getChallengeSymbol(tile.challenge?.id ?? '');
    _drawCenteredText(canvas, pos, symbol, 13.0);
  }

  /// 3. Kasta Om (Reroll Extra Turn)
  void _drawKastaOmTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 15.0;

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
      ..strokeWidth = 2.0;
    canvas.drawCircle(pos, radius, borderPaint);

    _drawCenteredText(canvas, pos, '🎲', 13.0);
  }

  /// 4. Station Hub (Holder Cup station)
  void _drawStationHubTile(Canvas canvas, Offset pos, BoardTileModel tile) {
    const radius = 19.0;

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

    _drawCenteredText(canvas, pos, '🌟', 14.0);
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

  @override
  bool shouldRepaint(covariant BoardWheelPainter oldDelegate) {
    return oldDelegate.activeTile != activeTile ||
        oldDelegate.currentPlayerIndex != currentPlayerIndex ||
        oldDelegate.players != players ||
        oldDelegate.boardTiles != boardTiles;
  }
}
