import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeHeaderWidget extends StatelessWidget {
  final VoidCallback onScanQrTap;

  const HomeHeaderWidget({
    super.key,
    required this.onScanQrTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isCandyMode = state.rewardMode == RewardMode.candy;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: App title, QR button & Rules button
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: kCandyYellow.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              kQrScannerConnected,
                              style: kMiniBadgeStyle.copyWith(
                                color: const Color(0xFFD35400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        kHeaderTitle,
                        style: kHeaderTitleStyle,
                      ),
                    ],
                  ),
                ),
                // Scan QR action button
                InkWell(
                  onTap: onScanQrTap,
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: kBorderColor, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: kCandyRed,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                // Rules icon button
                InkWell(
                  onTap: () => context.push(Routes.rules),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: kBorderColor, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: kPrimaryTextColor,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Mode Toggle Bar (Godis mot vinst vs Shot-läge)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isCandyMode
                    ? kCandyGreen.withValues(alpha: 0.08)
                    : kShotModeColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: isCandyMode
                      ? kCandyGreen.withValues(alpha: 0.25)
                      : kShotModeColor.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isCandyMode
                        ? Icons.cookie_rounded
                        : Icons.local_bar_rounded,
                    color: isCandyMode ? kCandyGreen : kShotModeColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCandyMode
                              ? '$kModePrefix$kModeCandy'
                              : '$kModePrefix$kModeShot',
                          style: kModeTitleStyle.copyWith(
                            color: isCandyMode ? kCandyGreen : kShotModeColor,
                          ),
                        ),
                        Text(
                          isCandyMode ? kModeCandyDesc : kModeShotDesc,
                          style: kModeDescStyle,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(const ToggleRewardModeEvent());
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      backgroundColor: kWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: isCandyMode
                              ? kCandyGreen.withValues(alpha: 0.4)
                              : kShotModeColor.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    child: Text(
                      kSwitchMode,
                      style: kButtonSmallStyle.copyWith(
                        color: isCandyMode ? kCandyGreen : kShotModeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
