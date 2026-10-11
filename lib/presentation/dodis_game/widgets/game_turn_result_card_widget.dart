import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/board_tile_model.dart';
import '../../../data/models/challenge_model.dart';
import '../bloc/dodis_game_state.dart';

class GameTurnResultCardWidget extends StatelessWidget {
  final GamePlayer player;
  final int stepsMoved;
  final ChallengeModel? challenge;
  final BoardTileModel? landedTile;
  final VoidCallback onContinue;

  const GameTurnResultCardWidget({
    super.key,
    required this.player,
    required this.stepsMoved,
    this.challenge,
    this.landedTile,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final holderColor = player.holderColor ?? kHolderBlue;

    // Determine emoji badge
    String badgeEmoji = '🍧';
    if (landedTile != null) {
      switch (landedTile!.type) {
        case BoardTileType.blankCandy:
          badgeEmoji = '🍬';
          break;
        case BoardTileType.kastaOm:
          badgeEmoji = '🎲';
          break;
        case BoardTileType.challenge:
          badgeEmoji = '🎯';
          break;
        case BoardTileType.stationHub:
          badgeEmoji = '🌟';
          break;
      }
    }

    // Determine subtitle
    String subtitle;
    if (landedTile != null) {
      switch (landedTile!.type) {
        case BoardTileType.blankCandy:
          subtitle = landedTile!.hasCandy
              ? 'Candy Field (Godis)! Picked up 1 candy! 🍬'
              : 'Candy Field • Candy already collected';
          break;
        case BoardTileType.kastaOm:
          subtitle = 'Kasta Om! Extra roll granted — Roll again! 🎲';
          break;
        case BoardTileType.challenge:
          subtitle =
              'Utmaning: ${landedTile!.swedishTitle} • Tap to duel!';
          break;
        case BoardTileType.stationHub:
          subtitle =
              'Station: ${landedTile!.swedishTitle} • Tap to duel!';
          break;
      }
    } else if (challenge != null) {
      subtitle = 'Collected 1 Candy • ${challenge!.title}';
    } else {
      subtitle = 'Collected 1 Candy';
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: const Color(0xFFFFE082),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4A373).withValues(alpha: 0.25),
            blurRadius: 16.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // 3D Candy Holder / Cup Icon
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: holderColor.withValues(alpha: 0.18),
              border: Border.all(
                color: holderColor,
                width: 2.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: holderColor.withValues(alpha: 0.3),
                  blurRadius: 6.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                badgeEmoji,
                style: TextStyle(fontSize: 26.sp),
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Steps & Candy Reward Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${player.name == 'You' ? 'You' : player.name} moved $stepsMoved steps!',
                  style: GoogleFonts.comicNeue(
                    fontSize: 18.5.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E293B),
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.comicNeue(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0288D1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
