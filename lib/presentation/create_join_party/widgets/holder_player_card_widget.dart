import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../bloc/create_party_state.dart';

class HolderPlayerCardWidget extends StatelessWidget {
  final PartyPlayerModel player;
  final bool isActive;
  final VoidCallback onTap;

  const HolderPlayerCardWidget({
    super.key,
    required this.player,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: kPartyCardBackground,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isActive ? player.holderColor : kPartyInputBorder,
            width: isActive ? 2.4 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isActive ? player.holderColor : kPartyCardShadow)
                  .withValues(alpha: isActive ? 0.22 : 0.05),
              blurRadius: isActive ? 12.r : 6.r,
              offset: Offset(0, isActive ? 4.h : 2.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Avatar with Colored Border Ring
            Container(
              width: 84.w,
              height: 84.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: player.holderColor,
                  width: 3.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: player.holderColor.withValues(alpha: 0.35),
                    blurRadius: 8.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  player.avatarPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Player Name
            Text(
              player.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.comicNeue(
                fontSize: 17.sp,
                fontWeight: FontWeight.w900,
                color: kPartyTextDark,
              ),
            ),
            SizedBox(height: 2.h),

            // Color Name in Parenthesis
            Text(
              '(${player.holderColorName})',
              style: GoogleFonts.comicNeue(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w800,
                color: player.holderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
