import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/challenge_model.dart';
import '../bloc/dodis_game_state.dart';

class ActiveChallengeModal extends StatelessWidget {
  final ChallengeModel challenge;
  final List<GamePlayer> allPlayers;
  final GamePlayer currentPlayer;
  final String? selectedOpponent;
  final ValueChanged<String> onSelectOpponent;
  final ValueChanged<bool> onCompleteChallenge;

  const ActiveChallengeModal({
    super.key,
    required this.challenge,
    required this.allPlayers,
    required this.currentPlayer,
    required this.selectedOpponent,
    required this.onSelectOpponent,
    required this.onCompleteChallenge,
  });

  @override
  Widget build(BuildContext context) {
    final opponents = allPlayers.where((p) => p.id != currentPlayer.id).toList();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: challenge.accentColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: challenge.accentColor.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Icon
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: challenge.accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  challenge.icon,
                  color: challenge.accentColor,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: kHeadingMedium,
                    ),
                    Text(
                      challenge.subtitle,
                      style: kBodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: challenge.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kCandyYellow.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$kCandyRewardPrefix${challenge.candyReward}',
                  style: kHeroBadgeStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Instructions
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              challenge.instruction,
              style: kBodyMedium.copyWith(
                color: kPrimaryTextColor,
                height: 1.45,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Opponent Selector
          if (opponents.isNotEmpty) ...[
            Text(
              kWhoToChallenge,
              style: kHeadingSmall.copyWith(fontSize: 12.5.sp),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children: opponents.map((opp) {
                final isSelected = selectedOpponent == opp.name;
                return ChoiceChip(
                  label: Text(opp.name),
                  selected: isSelected,
                  selectedColor: challenge.accentColor.withValues(alpha: 0.2),
                  labelStyle: kChipTextStyle.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? challenge.accentColor : kPrimaryTextColor,
                  ),
                  onSelected: (val) {
                    if (val) onSelectOpponent(opp.name);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
          ],

          // Resolution Buttons
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton.icon(
                  onPressed: () => onCompleteChallenge(true),
                  icon: const Icon(Icons.check_circle_rounded, color: kWhite),
                  label: Text(
                    kWinCandyAction,
                    style: kButtonSmallStyle.copyWith(fontSize: 12.5.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kCandyGreen,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () => onCompleteChallenge(false),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: const BorderSide(color: kBorderColor, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    kFailedAction,
                    style: kButtonSmallStyle.copyWith(
                      color: kSecondaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
