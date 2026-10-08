import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class DodisHeroCardWidget extends StatelessWidget {
  const DodisHeroCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2C2C54),
            Color(0xFF474787),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C2C54).withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative candy rings
          Positioned(
            right: -25.w,
            top: -25.h,
            child: Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 12.w,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15.w,
            bottom: -30.h,
            child: Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kCandyYellow.withValues(alpha: 0.12),
                  width: 8.w,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: kCandyYellow,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        kMainGameBadge,
                        style: kHeroBadgeStyle,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.track_changes_rounded,
                        color: kCandyYellow,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  kCategoryDodis.toUpperCase(),
                  style: kHeadingHero,
                ),
                SizedBox(height: 6.h),
                Text(
                  kDodisHeroDescription,
                  style: kHeroDescriptionStyle,
                ),
                SizedBox(height: 18.h),
                // Buttons row
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(Routes.dodisGame),
                        icon: Icon(Icons.play_arrow_rounded, color: kPrimaryTextColor, size: 22.sp),
                        label: Text(
                          kStartGame,
                          style: kButtonMediumStyle.copyWith(color: kPrimaryTextColor),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kCandyYellow,
                          foregroundColor: kPrimaryTextColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () => context.push(Routes.rules),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Text(
                          kRules,
                          style: kButtonMediumStyle.copyWith(fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
