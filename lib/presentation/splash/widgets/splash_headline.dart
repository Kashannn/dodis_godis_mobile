import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';

/// Styled packaging badge text: "CONTAINS +50 GAMES" & "Made entirely of candy"
class SplashHeadline extends StatelessWidget {
  const SplashHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // "CONTAINS"
        _buildStrokedText(
          text: 'CONTAINS',
          fontSize: 20.sp,
          color: const Color(0xFFD61A28),
          outlineColor: const Color(0xFF5B050B),
        ),
        // "+50"
        _buildStrokedText(
          text: '+50',
          fontSize: 34.sp,
          color: const Color(0xFFE21B27),
          outlineColor: const Color(0xFF5B050B),
        ),
        // "GAMES"
        _buildStrokedText(
          text: 'GAMES',
          fontSize: 22.sp,
          color: const Color(0xFFD61A28),
          outlineColor: const Color(0xFF5B050B),
        ),
        SizedBox(height: 6.h),
        // "Made entirely of candy"
        Text(
          kMadeEntirelyOfCandy,
          style: kSplashSubtitleStyle.copyWith(
            fontSize: 12.sp,
            shadows: [
              const Shadow(
                color: Colors.white,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStrokedText({
    required String text,
    required double fontSize,
    required Color color,
    required Color outlineColor,
  }) {
    return Stack(
      children: [
        // Dark cartoon outline stroke
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.5
              ..color = outlineColor,
          ),
        ),
        // Vibrant red fill
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
            color: color,
            shadows: const [
              Shadow(
                color: Colors.white70,
                blurRadius: 2,
                offset: Offset(-1, -1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
