import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class ChallengeCardWidget extends StatelessWidget {
  final int number;
  final String title;
  final String swedishSubtitle;
  final String description;
  final String tag;
  final String imagePath;
  final Color accentColor;
  final VoidCallback? onPlayTap;

  const ChallengeCardWidget({
    super.key,
    required this.number,
    required this.title,
    required this.swedishSubtitle,
    required this.description,
    required this.tag,
    required this.imagePath,
    required this.accentColor,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: accentColor.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 14.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Row with Number & Tag
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '$kChallengeBadgePrefix$number',
                    style: kButtonSmallStyle.copyWith(
                      color: kWhite,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      tag,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeroBadgeStyle.copyWith(
                        color: accentColor,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: kCandyYellow.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars_rounded, color: const Color(0xFFE67E22), size: 13.sp),
                      SizedBox(width: 3.w),
                      Text(
                        kOneCandyPiece,
                        style: kBodySmall.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF964B00),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Illustration Image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: accentColor.withValues(alpha: 0.15),
                          child: Center(
                            child: Icon(Icons.casino_rounded, size: 48.sp, color: accentColor),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.fullscreen_rounded,
                        color: kWhite,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Titles & English explanation
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kHeadingSmall.copyWith(
                    fontSize: 18.sp,
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: kBorderColor),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '🇸🇪 ',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      Expanded(
                        child: Text(
                          swedishSubtitle,
                          style: kBodySmall.copyWith(
                            fontSize: 11.sp,
                            fontStyle: FontStyle.italic,
                            color: kSecondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  kHowToPlayLabel,
                  style: kBodySmall.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: kBodyMedium.copyWith(
                    fontSize: 13.sp,
                    height: 1.45,
                    color: kPrimaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
