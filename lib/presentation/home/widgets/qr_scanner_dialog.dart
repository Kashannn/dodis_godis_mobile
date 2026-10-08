import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

class QrScannerDialog extends StatelessWidget {
  const QrScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            kScanDialogTitle,
            style: kHeadingMedium,
          ),
          SizedBox(height: 6.h),
          Text(
            kScanDialogDescription,
            textAlign: TextAlign.center,
            style: kBodyMedium,
          ),
          SizedBox(height: 20.h),
          // Viewfinder mockup
          Container(
            width: 180.w,
            height: 180.w,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: kCandyRed, width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    size: 80.sp,
                    color: kPrimaryTextColor,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    kSearchingQr,
                    style: kBodySmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            kQuickStartOptions,
            style: kHeadingXSmall.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            alignment: WrapAlignment.center,
            children: [
              ActionChip(
                avatar: const Icon(Icons.circle, color: kCandyRed, size: 16),
                label: const Text(kChipDodisFront),
                labelStyle: kChipTextStyle.copyWith(fontSize: 11.sp),
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.dodisGame);
                },
              ),
              ActionChip(
                avatar: const Icon(Icons.casino, color: kCandyYellow, size: 16),
                label: const Text(kChipYatzyBack),
                labelStyle: kChipTextStyle.copyWith(fontSize: 11.sp),
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.yatzy);
                },
              ),
              ActionChip(
                avatar: const Icon(Icons.favorite, color: kCandyPink, size: 16),
                label: const Text(kChipDateCards),
                labelStyle: kChipTextStyle.copyWith(fontSize: 11.sp),
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.dateCards);
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
