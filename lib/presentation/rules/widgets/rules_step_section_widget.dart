import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class RulesStepSectionWidget extends StatelessWidget {
  final VoidCallback? onQrTap;

  const RulesStepSectionWidget({
    super.key,
    this.onQrTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Setup Card (FÖRBEREDELSER)
        _buildCard(
          accentColor: kCandyBlue,
          badgeText: 'FÖRBEREDELSER',
          title: kSetupTitle,
          subtitle: kSetupSubtitle,
          steps: [
            _RuleStepItem(
              number: '1',
              title: kSetupStep1Title,
              description: kSetupStep1Desc,
              icon: Icons.scatter_plot_rounded,
              color: kCandyPink,
            ),
            _RuleStepItem(
              number: '2',
              title: kSetupStep2Title,
              description: kSetupStep2Desc,
              icon: Icons.sports_bar_rounded,
              color: kCandyYellow,
            ),
            _RuleStepItem(
              number: '3',
              title: kSetupStep3Title,
              description: kSetupStep3Desc,
              icon: Icons.play_circle_fill_rounded,
              color: kCandyGreen,
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // 2. On Your Turn Card (NÄR DET ÄR DIN TUR)
        _buildCard(
          accentColor: kCandyPink,
          badgeText: 'NÄR DET ÄR DIN TUR',
          title: kTurnTitle,
          subtitle: kTurnSubtitle,
          steps: [
            _RuleStepItem(
              number: '1',
              title: kTurnStep1Title,
              description: kTurnStep1Desc,
              icon: Icons.casino_rounded,
              color: kCandyRed,
              tipText: kTurnStep1Tip,
              onTipTap: onQrTap,
            ),
            _RuleStepItem(
              number: '2',
              title: kTurnStep2Title,
              description: kTurnStep2Desc,
              icon: Icons.emoji_events_rounded,
              color: kCandyYellow,
            ),
            _RuleStepItem(
              number: '3',
              title: kTurnStep3Title,
              description: kTurnStep3Desc,
              icon: Icons.stars_rounded,
              color: kCandyPurple,
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // 3. How to Win Card (SÅHÄR VINNER DU)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF7B9B), Color(0xFFFF527B), Color(0xFFE84118)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: kCandyRed.withValues(alpha: 0.25),
                blurRadius: 16.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: kWhite.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'SÅHÄR VINNER DU',
                      style: kButtonSmallStyle.copyWith(
                        color: kWhite,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.workspace_premium_rounded, color: kCandyYellow, size: 28.sp),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                kWinningTrophyTitle,
                style: kHeadingMedium.copyWith(
                  color: kWhite,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                kWinningDesc,
                style: kBodyMedium.copyWith(
                  color: kWhite.withValues(alpha: 0.95),
                  fontSize: 13.5.sp,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required Color accentColor,
    required String badgeText,
    required String title,
    required String subtitle,
    required List<_RuleStepItem> steps,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              badgeText,
              style: kHeroBadgeStyle.copyWith(
                color: accentColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: kHeadingSmall.copyWith(
              fontSize: 17.sp,
              color: kPrimaryTextColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: kBodySmall.copyWith(
              color: kSecondaryTextColor,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 14.h),
          ...steps.map((step) => _buildStepRow(step)),
        ],
      ),
    );
  }

  Widget _buildStepRow(_RuleStepItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(item.icon, color: item.color, size: 18.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: kHeadingSmall.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  item.description,
                  style: kBodyMedium.copyWith(
                    fontSize: 12.5.sp,
                    color: kSecondaryTextColor,
                    height: 1.4,
                  ),
                ),
                if (item.tipText != null) ...[
                  SizedBox(height: 6.h),
                  InkWell(
                    onTap: item.onTipTap,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: kCandyYellow.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: kCandyYellow.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.qr_code_scanner_rounded, color: const Color(0xFFD35400), size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              item.tipText!,
                              style: kBodySmall.copyWith(
                                color: const Color(0xFF964B00),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleStepItem {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String? tipText;
  final VoidCallback? onTipTap;

  _RuleStepItem({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.tipText,
    this.onTipTap,
  });
}
