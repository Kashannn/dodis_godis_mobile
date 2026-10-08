import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

/// The bottom ribbon banner of the Dodis Godis packaging with tagline and tap trigger.
class SplashBottomBanner extends StatelessWidget {
  final VoidCallback onTap;

  const SplashBottomBanner({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Packaging bottom banner strip
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFB6C9),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.9),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            kPackagingTagline,
            textAlign: TextAlign.center,
            style: kSplashBannerStyle.copyWith(
              fontSize: 9.5.sp,
            ),
          ),
        ),

        SizedBox(height: 10.h),

        // Animated interactive 'TAP TO START' pill
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 22.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF3366),
                  Color(0xFFE91E63),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE91E63).withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_fill_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  kTapToEnter,
                  style: kSplashTapPromptStyle.copyWith(
                    fontSize: 11.5.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 11.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
