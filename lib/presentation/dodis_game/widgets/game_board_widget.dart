import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_images.dart';
import '../bloc/dodis_game_state.dart';
import 'board_wheel_painter.dart';

class GameBoardWidget extends StatelessWidget {
  final int activeTile;
  final List<GamePlayer> players;
  final int currentPlayerIndex;

  const GameBoardWidget({
    super.key,
    required this.activeTile,
    required this.players,
    required this.currentPlayerIndex,
  });

  @override
  Widget build(BuildContext context) {
    final boardSize = math.min(340.w, 340.h);

    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Ambient Background Glow Disc
          Container(
            width: boardSize + 24.w,
            height: boardSize + 24.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4A373).withValues(alpha: 0.18),
                  blurRadius: 32.r,
                  spreadRadius: 8.r,
                ),
              ],
            ),
          ),

          // 2. Decorative 3D Candies scattered around the board
          Positioned(
            top: -10.h,
            left: 2.w,
            child: Transform.rotate(
              angle: -0.2,
              child: Image.asset(
                kCandyBeanYellow,
                width: 38.w,
                height: 38.h,
              ),
            ),
          ),
          Positioned(
            top: 6.h,
            right: 8.w,
            child: Transform.rotate(
              angle: 0.35,
              child: Image.asset(
                kCandyBeanRed,
                width: 36.w,
                height: 36.h,
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 6.w,
            child: Transform.rotate(
              angle: 0.4,
              child: Image.asset(
                kCandyBeanGreen,
                width: 42.w,
                height: 42.h,
              ),
            ),
          ),
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: Transform.rotate(
              angle: -0.3,
              child: Image.asset(
                kCandyBeanYellow,
                width: 34.w,
                height: 34.h,
              ),
            ),
          ),

          // 3. Central Canvas with 24 Candy Nodes, Spinner & 3D Pawns
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: CustomPaint(
              painter: BoardWheelPainter(
                activeTile: activeTile,
                players: players,
                currentPlayerIndex: currentPlayerIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
