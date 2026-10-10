import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class PartyHeroHeaderWidget extends StatelessWidget {
  final Animation<double> floatAnim;

  const PartyHeroHeaderWidget({
    super.key,
    required this.floatAnim,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [



        // 2. 3D Kids Party Game & Candy Mountain Composition
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Ambient Radial Glow
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kPartyPrimaryBlue.withValues(alpha: 0.22),
                    blurRadius: 38.r,
                    spreadRadius: 6.r,
                  ),
                ],
              ),
            ),

            // Floating Kids Game Art Card
            AnimatedBuilder(
              animation: floatAnim,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, floatAnim.value),
                  child: child,
                );
              },
              child: Container(
                width: 215.w,
                height: 175.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.r),
                  border: Border.all(
                    color: kWhite,
                    width: 3.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPartyCardShadow.withValues(alpha: 0.16),
                      blurRadius: 18.r,
                      offset: Offset(0, 8.h),
                    ),
                    BoxShadow(
                      color: kWhite.withValues(alpha: 0.85),
                      blurRadius: 6.r,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23.r),
                  child: Image.asset(
                    kKidsPartyGame,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Candy Mountain Pile (overlapping bottom-right with 3D depth)
            Positioned(
              right: 6.w,
              bottom: -6.h,
              child: AnimatedBuilder(
                animation: floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -floatAnim.value * 0.5),
                    child: child,
                  );
                },
                child: Image.asset(
                  kCandyMountain,
                  width: 82.w,
                  height: 82.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Floating Red Jelly Bean (Top-Left)
            Positioned(
              left: 10.w,
              top: 6.h,
              child: AnimatedBuilder(
                animation: floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -floatAnim.value * 0.7),
                    child: child,
                  );
                },
                child: Image.asset(
                  kCandyBeanRed,
                  width: 34.w,
                  height: 34.h,
                ),
              ),
            ),

            // Floating Yellow Jelly Bean (Top-Right)
            Positioned(
              right: 18.w,
              top: 10.h,
              child: AnimatedBuilder(
                animation: floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, floatAnim.value * 0.8),
                    child: child,
                  );
                },
                child: Image.asset(
                  kCandyBeanYellow,
                  width: 32.w,
                  height: 32.h,
                ),
              ),
            ),

            // Floating Green Candy (Mid-Left)
            Positioned(
              left: 18.w,
              bottom: 8.h,
              child: AnimatedBuilder(
                animation: floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, floatAnim.value * 0.6),
                    child: child,
                  );
                },
                child: Image.asset(
                  kCandyBeanGreen,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
