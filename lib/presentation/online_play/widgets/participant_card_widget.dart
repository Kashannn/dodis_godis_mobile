import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class ParticipantCardWidget extends StatelessWidget {
  final String name;
  final String subtitle;
  final Color color;
  final bool isHost;

  const ParticipantCardWidget({
    super.key,
    required this.name,
    required this.subtitle,
    required this.color,
    required this.isHost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(Icons.videocam_rounded, color: color, size: 16.sp),
              ),
              if (isHost)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    kHostBadge,
                    style: kMiniBadgeStyle.copyWith(
                      fontSize: 8.sp,
                      color: kWhite,
                    ),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kHeadingSmall.copyWith(fontSize: 12.sp),
              ),
              Text(
                subtitle,
                style: kCaption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
