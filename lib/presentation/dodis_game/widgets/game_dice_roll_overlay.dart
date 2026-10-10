import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_images.dart';
import '../../splash/widgets/tap_to_play_button.dart';
import '../bloc/dodis_game_state.dart';
import 'dice_roller_widget.dart';
import 'player_roster_bar.dart';

class GameDiceRollOverlay extends StatelessWidget {
  final GamePlayer currentPlayer;
  final List<GamePlayer> allPlayers;
  final int currentPlayerIndex;
  final int diceValue;
  final bool isRolling;
  final VoidCallback onRoll;
  final VoidCallback onClose;

  const GameDiceRollOverlay({
    super.key,
    required this.currentPlayer,
    required this.allPlayers,
    required this.currentPlayerIndex,
    required this.diceValue,
    required this.isRolling,
    required this.onRoll,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF29B6F6),
            Color(0xFF0288D1),
            Color(0xFF01579B),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Close / Back button row
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // 1. Top Active Player Card (Matching Screenshot 2)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        currentPlayer.avatarPath ??
                            kPlayerAvatarList[
                                currentPlayer.avatarIndex % kPlayerAvatarList.length],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),

                  // Name
                  Expanded(
                    child: Text(
                      currentPlayer.name,
                      style: GoogleFonts.comicNeue(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Candy Count Badge
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🍬', style: TextStyle(fontSize: 16.sp)),
                        SizedBox(width: 6.w),
                        Text(
                          '${currentPlayer.candyCount}',
                          style: GoogleFonts.comicNeue(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 2. Central 3D Dice with Glowing Sunburst Stage
            Stack(
              alignment: Alignment.center,
              children: [
                // Radiant Sunburst Aura Disc
                Container(
                  width: 220.w,
                  height: 220.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),

                // White Circular Stage Disc
                Container(
                  width: 170.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20.r,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),

                // 3D Dice Roller
                GestureDetector(
                  onTap: isRolling ? null : onRoll,
                  child: DiceRollerWidget(
                    diceValue: diceValue,
                    isRolling: isRolling,
                    onRoll: onRoll,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // 3. "Tap to Roll Dice" Action Pill Button
            TapToPlayButton(
              text: isRolling ? 'Rolling...' : 'Tap to Roll Dice',
              width: 280.w,
              height: 58.h,
              fontSize: 21.sp,
              gradientColors: const [
                Color(0xFF40C4FF),
                Color(0xFF0091EA),
                Color(0xFF0277BD),
              ],
              borderColor: Colors.white,
              textColor: Colors.white,
              onPressed: isRolling ? null : onRoll,
            ),

            const Spacer(),

            // 4. Bottom Player Roster with Active Indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.15),
              ),
              child: Column(
                children: [
                  PlayerRosterBar(
                    players: allPlayers,
                    currentPlayerIndex: currentPlayerIndex,
                  ),
                  SizedBox(height: 6.h),
                  // Active Player Indicator Dot
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
