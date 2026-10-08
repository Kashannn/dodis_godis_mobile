import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/date_card_model.dart';

class DateCardDisplay extends StatelessWidget {
  final DateCardModel card;

  const DateCardDisplay({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final isNaughty = card.category == DateCardCategory.naughty18;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: isNaughty
              ? kShotModeColor.withValues(alpha: 0.3)
              : kCandyPink.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isNaughty ? kShotModeColor : kCandyPink)
                .withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: (isNaughty ? kShotModeColor : kCandyPink)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              isNaughty ? kBadgeNaughty : kBadgeCozy,
              style: kDateBadgeStyle.copyWith(
                color: isNaughty ? kShotModeColor : kCandyPink,
              ),
            ),
          ),
          const Spacer(),
          Text(
            card.question,
            textAlign: TextAlign.center,
            style: kDateQuestionStyle,
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cookie_outlined, color: kCandyYellow, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      kCandyRuleConsequence,
                      style: kHeroBadgeStyle.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xFF964B00),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  card.candyConsequence,
                  textAlign: TextAlign.center,
                  style: kBodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
