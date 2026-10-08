import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class YatzyDiceWidget extends StatelessWidget {
  final List<int> dice;
  final List<bool> heldDice;
  final int rollsRemaining;
  final bool isRolling;
  final void Function(int) onToggleHold;
  final VoidCallback onRoll;

  const YatzyDiceWidget({
    super.key,
    required this.dice,
    required this.heldDice,
    required this.rollsRemaining,
    required this.isRolling,
    required this.onToggleHold,
    required this.onRoll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: kBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kFiveCandyDice,
                style: kHeadingSmall.copyWith(fontSize: 13.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: rollsRemaining > 0
                      ? kCandyGreen.withValues(alpha: 0.15)
                      : kCandyRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$rollsRemaining$kRollsLeftSuffix',
                  style: kMiniBadgeStyle.copyWith(
                    fontSize: 11.sp,
                    color: rollsRemaining > 0 ? kCandyGreen : kCandyRed,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // 5 Dice row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final isHeld = heldDice[index];
              final value = dice[index];

              return GestureDetector(
                onTap: () => onToggleHold(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: isHeld ? kCandyRed : kWhite,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isHeld ? kCandyRed : kCandyRed.withValues(alpha: 0.5),
                      width: 2.2,
                    ),
                    boxShadow: isHeld
                        ? [
                            BoxShadow(
                              color: kCandyRed.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$value',
                        style: kDicePipNumberStyle.copyWith(
                          color: isHeld ? kWhite : kPrimaryTextColor,
                        ),
                      ),
                      if (isHeld)
                        Text(
                          kSaveBadge,
                          style: kSaveBadgeStyle,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 14.h),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton.icon(
              onPressed: rollsRemaining > 0 && !isRolling ? onRoll : null,
              icon: Icon(Icons.casino_rounded, size: 18.sp, color: kWhite),
              label: Text(
                rollsRemaining > 0
                    ? 'Slå Tärningarna ($rollsRemaining)'
                    : kNoRollsLeftChoose,
                style: kButtonSmallStyle.copyWith(fontSize: 13.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kCandyRed,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
