import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/game_category_model.dart';

class CategorySectionWidget extends StatelessWidget {
  final GameCategoryModel category;
  final void Function(GameItemModel) onGameTap;

  const CategorySectionWidget({
    super.key,
    required this.category,
    required this.onGameTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header Row
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: category.accentColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                category.title.toUpperCase(),
                style: kCategoryTagStyle,
              ),
              SizedBox(width: 6.w),
              Text(
                '– ${category.games.map((g) => g.title).join(", ")}',
                style: kBodySmall.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        // Games in this category
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.games.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final game = category.games[index];
            return InkWell(
              onTap: () => onGameTap(game),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: kBorderColor, width: 1.1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: game.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        game.icon,
                        color: game.color,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                game.title,
                                style: kHeadingSmall.copyWith(fontSize: 14.sp),
                              ),
                              if (game.badgeText.isNotEmpty) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: game.color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    game.badgeText,
                                    style: kMiniBadgeStyle.copyWith(
                                      fontSize: 8.5.sp,
                                      color: game.color,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            game.subtitle,
                            style: kBodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: kSecondaryTextColor.withValues(alpha: 0.6),
                      size: 22.sp,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
