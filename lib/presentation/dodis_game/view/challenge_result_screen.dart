import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../splash/widgets/tap_to_play_button.dart';

class ChallengeResultScreen extends StatelessWidget {
  final String playerName;
  final int candiesWon;
  final VoidCallback onContinue;

  const ChallengeResultScreen({
    super.key,
    required this.playerName,
    this.candiesWon = 1,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = playerName.isEmpty || playerName == 'You' ? 'You' : playerName;

    return AppCustomScaffold(
      safeTop: false,
      safeBottom: false,
      extendBodyBehindAppBar: true,
      statusBarIconBrightness: Brightness.light,
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // 1. Background Image (kChallengeSuccessHero) extends all the way to top edge
            Positioned.fill(
              child: Image.asset(
                kChallengeSuccessHero,
                fit: BoxFit.cover,
              ),
            ),

            // 2. Foreground UI Content inside SafeArea so content is not cut
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Subtitle: "You won 3 candies!"
                  Text(
                    '$displayName won $candiesWon ${candiesWon == 1 ? 'candy' : 'candies'}!',
                    style: GoogleFonts.comicNeue(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.3,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 4.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16.h),

                  // Row of 3D Candy Beans
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCandyBean(kCandyBeanYellow, 30.w, 30.h, -0.15),
                      SizedBox(width: 12.w),
                      _buildCandyBean(kCandyBeanRed, 40.w, 40.h, 0.1),
                      SizedBox(width: 12.w),
                      _buildGlossyCandyCircle(const Color(0xFF29B6F6), 34.w),
                      SizedBox(width: 12.w),
                      _buildCandyBean(kCandyBeanYellow, 38.w, 38.h, -0.1),
                      SizedBox(width: 12.w),
                      _buildCandyBean(kCandyBeanGreen, 32.w, 32.h, 0.2),
                    ],
                  ),

                  const Spacer(flex: 3),

                  // Green Continue Button (using TapToPlayButton)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
                    child: TapToPlayButton(
                      text: 'Continue',
                      width: 320.w,
                      height: 62.h,
                      fontSize: 24.sp,
                      gradientColors: const [
                        Color(0xFF45D461),
                        Color(0xFF28B744),
                        Color(0xFF1A9331),
                      ],
                      borderColor: const Color(0xFF116522),
                      textColor: Colors.white,
                      onPressed: onContinue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandyBean(String assetPath, double width, double height, double rotate) {
    return Transform.rotate(
      angle: rotate,
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildGlossyCandyCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.35),
          radius: 0.85,
          colors: [
            Colors.white.withValues(alpha: 0.9),
            color,
            Color.lerp(color, Colors.black, 0.3)!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}