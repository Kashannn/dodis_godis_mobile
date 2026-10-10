import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

enum GameModeOption { classic, quick }

class PartyModeSelectorWidget extends StatelessWidget {
  final GameModeOption selectedMode;
  final ValueChanged<GameModeOption> onModeChanged;

  const PartyModeSelectorWidget({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.sports_esports_rounded,
              color: kPartyPrimaryBlue,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              kGameModeLabel,
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: kPartyTextDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        Row(
          children: [
            // Classic Mode Card
            Expanded(
              child: GestureDetector(
                onTap: () => onModeChanged(GameModeOption.classic),
                behavior: HitTestBehavior.opaque,
                child: _buildModeCard(
                  label: kGameModeClassic,
                  isSelected: selectedMode == GameModeOption.classic,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Quick Mode Card
            Expanded(
              child: GestureDetector(
                onTap: () => onModeChanged(GameModeOption.quick),
                behavior: HitTestBehavior.opaque,
                child: _buildModeCard(
                  label: kGameModeQuick,
                  isSelected: selectedMode == GameModeOption.quick,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeCard({
    required String label,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF0F7FF) : kPartyUnselectedFill,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? kPartyLightBlue : kPartyInputBorder,
          width: isSelected ? 1.8 : 1.4,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? kPartyPrimaryBlue : kPartyTextSubtle,
                width: 2.0,
              ),
              color: isSelected ? kWhite : Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPartyPrimaryBlue,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.comicNeue(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
              color: isSelected ? kPartyDarkBlue : kPartyTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
