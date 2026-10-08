import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class RulesHeaderBannerWidget extends StatelessWidget {
  const RulesHeaderBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: kBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kCandyRed.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_stories_rounded, color: kCandyRed, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      kRulesHeaderBadge,
                      style: kHeroBadgeStyle.copyWith(
                        color: kCandyRed,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                kSwedishFlag,
                width: 28.w,
                height: 20.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Text('🇸🇪', style: TextStyle(fontSize: 18.sp)),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Colorful Candy Letters Title: "DODIS GODIS SPELET"
          _buildRainbowTitle(),
          SizedBox(height: 8.h),

          // Subtitle
          Text(
            kRulesSubtitle,
            textAlign: TextAlign.center,
            style: kBodySmall.copyWith(
              color: kSecondaryTextColor,
              fontSize: 12.5.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRainbowTitle() {
    // Letter colors matching Swedish playful candy packaging:
    // D(red), O(orange), D(yellow), I(green), S(blue) ...
    const titleParts = [
      ('DODIS', [
        Color(0xFFFF3366),
        Color(0xFFFF8C00),
        Color(0xFFFFD700),
        Color(0xFF2ED573),
        Color(0xFF1E90FF),
      ]),
      ('GODIS', [
        Color(0xFFFF4757),
        Color(0xFFFFA502),
        Color(0xFF2ED573),
        Color(0xFF3742FA),
        Color(0xFFFF6B81),
      ]),
      ('SPELET', [
        Color(0xFF70A1FF),
        Color(0xFF5352ED),
        Color(0xFFFF6348),
        Color(0xFF2ED573),
        Color(0xFFFFA502),
        Color(0xFFFF4757),
      ]),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.w,
      runSpacing: 4.h,
      children: titleParts.map((part) {
        final text = part.$1;
        final colors = part.$2;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(text.length, (i) {
            final color = colors[i % colors.length];
            return Text(
              text[i],
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: color.withValues(alpha: 0.35),
                    offset: Offset(0, 2.h),
                    blurRadius: 4.r,
                  ),
                ],
              ),
            );
          }),
        );
      }).toList(),
    );
  }
}
