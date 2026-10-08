import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class DiceRollerWidget extends StatelessWidget {
  final int diceValue;
  final bool isRolling;
  final VoidCallback onRoll;

  const DiceRollerWidget({
    super.key,
    required this.diceValue,
    required this.isRolling,
    required this.onRoll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: isRolling ? null : onRoll,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: kCandyRed, width: 3),
              boxShadow: [
                BoxShadow(
                  color: kCandyRed.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: isRolling
                  ? const CircularProgressIndicator(color: kCandyRed)
                  : _buildDiceFace(diceValue),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        ElevatedButton.icon(
          onPressed: isRolling ? null : onRoll,
          icon: Icon(Icons.casino_rounded, color: kWhite, size: 20.sp),
          label: Text(
            isRolling ? kRollingDice : kRollDiceAction,
            style: kButtonMediumStyle,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kCandyRed,
            foregroundColor: kWhite,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildDiceFace(int value) {
    final pips = <int, List<int>>{
      1: [4],
      2: [0, 8],
      3: [0, 4, 8],
      4: [0, 2, 6, 8],
      5: [0, 2, 4, 6, 8],
      6: [0, 2, 3, 5, 6, 8],
    }[value] ?? [4];

    return Container(
      padding: EdgeInsets.all(12.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          final showPip = pips.contains(index);
          if (!showPip) return const SizedBox();
          return Container(
            decoration: const BoxDecoration(
              color: kCandyRed,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
