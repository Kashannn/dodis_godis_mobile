import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../bloc/dodis_game_state.dart';

class PlayerRosterBar extends StatelessWidget {
  final List<GamePlayer> players;
  final int currentPlayerIndex;
  final VoidCallback? onAddPlayer;

  const PlayerRosterBar({
    super.key,
    required this.players,
    required this.currentPlayerIndex,
    this.onAddPlayer,
  });

  List<Color> _getPlayerGradient(Color baseColor) {
    if (baseColor == kHolderBlue) {
      return const [Color(0xFF29B6F6), Color(0xFF0288D1)];
    } else if (baseColor == kHolderOrange) {
      return const [Color(0xFFFFA726), Color(0xFFF57C00)];
    } else if (baseColor == kHolderPurple) {
      return const [Color(0xFFBA68C8), Color(0xFF7B1FA2)];
    } else if (baseColor == kHolderGreen) {
      return const [Color(0xFF66BB6A), Color(0xFF388E3C)];
    } else if (baseColor == kHolderRed) {
      return const [Color(0xFFEF5350), Color(0xFFC62828)];
    } else if (baseColor == kHolderYellow) {
      return const [Color(0xFFFFEE58), Color(0xFFF9A825)];
    }
    return [baseColor.withValues(alpha: 0.8), baseColor];
  }

  @override
  Widget build(BuildContext context) {
    final showScroll = players.length > 4;

    Widget buildCards() {
      return Row(
        mainAxisAlignment:
            showScroll ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
        children: players.asMap().entries.map((entry) {
          final index = entry.key;
          final player = entry.value;
          final isCurrent = index == currentPlayerIndex;
          final baseColor = player.holderColor ??
              [
                kHolderBlue,
                kHolderOrange,
                kHolderPurple,
                kHolderGreen,
                kHolderRed,
                kHolderYellow,
              ][index % 6];
          final gradientColors = _getPlayerGradient(baseColor);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: AnimatedScale(
              scale: isCurrent ? 1.05 : 0.95,
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 78.w,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: isCurrent ? Colors.white : Colors.white.withValues(alpha: 0.5),
                    width: isCurrent ? 2.4 : 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: baseColor.withValues(alpha: isCurrent ? 0.45 : 0.15),
                      blurRadius: isCurrent ? 12.r : 4.r,
                      offset: Offset(0, isCurrent ? 5.h : 2.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Avatar
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4.r,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          player.avatarPath ??
                              kPlayerAvatarList[
                                  player.avatarIndex % kPlayerAvatarList.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),

                    // Player Name
                    Text(
                      player.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.comicNeue(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // Candies Count Capsule
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🍬',
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            '${player.candyCount}',
                            style: GoogleFonts.comicNeue(
                              fontSize: 13.5.sp,
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
            ),
          );
        }).toList(),
      );
    }

    if (showScroll) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: buildCards(),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: buildCards(),
    );
  }
}
