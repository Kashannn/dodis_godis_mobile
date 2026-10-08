import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../bloc/dodis_game_state.dart';

class PlayerRosterBar extends StatelessWidget {
  final List<GamePlayer> players;
  final int currentPlayerIndex;
  final VoidCallback onAddPlayer;

  const PlayerRosterBar({
    super.key,
    required this.players,
    required this.currentPlayerIndex,
    required this.onAddPlayer,
  });

  @override
  Widget build(BuildContext context) {
    const avatarColors = [
      kCandyRed,
      kCandyYellow,
      kCandyGreen,
      kCandyBlue,
      kCandyPurple,
      kCandyOrange,
    ];

    return SizedBox(
      height: 82.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: players.length + 1,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          if (index == players.length) {
            return InkWell(
              onTap: onAddPlayer,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: 72.w,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: kBorderColor,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_rounded, color: kCandyBlue, size: 22.sp),
                    SizedBox(height: 4.h),
                    Text(
                      '+ Spelare',
                      style: kHeroBadgeStyle.copyWith(color: kCandyBlue),
                    ),
                  ],
                ),
              ),
            );
          }

          final player = players[index];
          final isCurrent = index == currentPlayerIndex;
          final color = avatarColors[player.avatarIndex % avatarColors.length];

          return Container(
            width: 105.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isCurrent ? color.withValues(alpha: 0.12) : kWhite,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isCurrent ? color : kBorderColor,
                width: isCurrent ? 2 : 1,
              ),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_drink_rounded,
                      color: color,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        player.name,
                        overflow: TextOverflow.ellipsis,
                        style: kHeadingSmall.copyWith(
                          fontSize: 11.5.sp,
                          fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                          color: isCurrent ? color : kPrimaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: kCandyYellow.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '🍬 ${player.candyCount} godis',
                    style: kHeroBadgeStyle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
