import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class PartyPlayerSelectorWidget extends StatelessWidget {
  final int selectedPlayerCount;
  final ValueChanged<int> onPlayerCountChanged;

  static const List<int> playerOptions = [2, 3, 4, 5, 6];

  static const List<Color> playerTokenColors = [
    kCandyRed,
    kCandyGreen,
    kCandyBlue,
    kCandyYellow,
    kCandyPurple,
    kCandyOrange,
  ];

  const PartyPlayerSelectorWidget({
    super.key,
    required this.selectedPlayerCount,
    required this.onPlayerCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          children: [
            Icon(
              Icons.groups_rounded,
              color: kPartyPrimaryBlue,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              kPlayersRangeLabel,
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: kPartyTextDark,
                letterSpacing: 0.2,
              ),
            ),
            const Spacer(),
            Text(
              '$selectedPlayerCount Players',
              style: GoogleFonts.comicNeue(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w900,
                color: kPartyPrimaryBlue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Number of Players Selector Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: playerOptions.map((count) {
            final isSelected = count == selectedPlayerCount;
            return GestureDetector(
              onTap: () => onPlayerCountChanged(count),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: kPartyBlueGradient,
                        )
                      : null,
                  color: isSelected ? null : kPartyUnselectedFill,
                  border: Border.all(
                    color: isSelected
                        ? kWhite.withValues(alpha: 0.85)
                        : kPartyInputBorder,
                    width: isSelected ? 2.0 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: kPartyPrimaryBlue.withValues(alpha: 0.4),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: GoogleFonts.comicNeue(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w900,
                      color: isSelected ? kWhite : kPartyTextMuted,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
