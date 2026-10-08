import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/game_category_model.dart';

class FeaturedGameCard extends StatelessWidget {
  final GameItemModel game;
  final VoidCallback onTap;

  const FeaturedGameCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: kBorderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: game.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    game.icon,
                    color: game.color,
                    size: 24.sp,
                  ),
                ),
                const Spacer(),
                if (game.badgeText.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: game.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      game.badgeText,
                      style: kMiniBadgeStyle.copyWith(color: game.color),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              game.title,
              style: kHeadingSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              game.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kBodySmall.copyWith(height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
