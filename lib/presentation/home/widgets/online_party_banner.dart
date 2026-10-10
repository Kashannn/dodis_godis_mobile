import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class OnlinePartyBanner extends StatelessWidget {
  const OnlinePartyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.createParty),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E3799),
            Color(0xFF0C2461),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0C2461).withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.tv_rounded,
              color: kCandyYellow,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      kPlayOnlineTv,
                      style: kHeadingSmall.copyWith(
                        fontSize: 13.sp,
                        color: kWhite,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: kCandyGreen,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        kNewBadge,
                        style: kMiniBadgeStyle.copyWith(
                          fontSize: 8.sp,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  kOnlineTvDescription,
                  style: kBodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push(Routes.createParty),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: kWhite,
              size: 16.sp,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
