import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../splash/widgets/tap_to_play_button.dart';

class GameWinnerScreen extends StatelessWidget {
  final String winnerName;
  final VoidCallback onPlayAgain;
  final VoidCallback onMainMenu;

  const GameWinnerScreen({
    super.key,
    required this.winnerName,
    required this.onPlayAgain,
    required this.onMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        winnerName.isEmpty || winnerName == 'You' ? 'You' : winnerName;

    return AppCustomScaffold(
      backgroundColor: const Color(0xFFE1F5FE),
      safeTop: false,
      safeBottom: false,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE1F5FE),
              Color(0xFFFFF9E6),
              Color(0xFFFFF0D4),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // 1. Royal Crown & 3D "Winner!" Ribbon Banner (Screenshot 2)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Image.asset(
                  kWinnerRibbonBanner,
                  width: 320.w,
                  height: 190.h,
                  fit: BoxFit.contain,
                ),
              ),

              // 2. Victorious Character Cheering (Hands raised high)
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Ambient winner glow
                      Container(
                        width: 210.w,
                        height: 210.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD54F).withValues(alpha: 0.35),
                              blurRadius: 36.r,
                              spreadRadius: 8.r,
                            ),
                          ],
                        ),
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(26.r),
                        child: Image.asset(
                          kWinnerCrownCharacter,
                          width: 220.w,
                          height: 220.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Victory Announcement Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      '$displayName collected\nall candies!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comicNeue(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1E293B),
                        height: 1.2,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Candy Champion 👑',
                      style: GoogleFonts.comicNeue(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // 4. Action Buttons (Play Again & Main Menu)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    // Green "Play Again" Button
                    TapToPlayButton(
                      text: 'Play Again',
                      width: 320.w,
                      height: 58.h,
                      fontSize: 23.sp,
                      gradientColors: const [
                        Color(0xFF45D461),
                        Color(0xFF28B744),
                        Color(0xFF1A9331),
                      ],
                      borderColor: const Color(0xFF116522),
                      textColor: Colors.white,
                      onPressed: onPlayAgain,
                    ),

                    SizedBox(height: 12.h),

                    // Yellow/Gold "Main Menu" Button
                    TapToPlayButton(
                      text: 'Main Menu',
                      width: 320.w,
                      height: 58.h,
                      fontSize: 23.sp,
                      gradientColors: const [
                        Color(0xFFFFEE58),
                        Color(0xFFFFCA28),
                        Color(0xFFFFA000),
                      ],
                      borderColor: const Color(0xFFE65100),
                      textColor: const Color(0xFF26190E),
                      onPressed: onMainMenu,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
