import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../widgets/tap_to_play_button.dart';

class TapToPlayScreen extends StatefulWidget {
  const TapToPlayScreen({super.key});

  @override
  State<TapToPlayScreen> createState() => _TapToPlayScreenState();
}

class _TapToPlayScreenState extends State<TapToPlayScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _floatAnim;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );

    _pulseAnim = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onTapPlay() {
    context.push(Routes.createJoinParty);
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: const Color(0xFFFAF5E8),
      safeBottom: true,
      body: GestureDetector(
        onTap: _onTapPlay,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.2),
              radius: 1.15,
              colors: [
                Color(0xFFFFFDF7),
                Color(0xFFFAF5E8),
                Color(0xFFF3ECE0),
              ],
            ),
          ),
          child: SafeArea(
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final h = constraints.maxHeight;
                    final w = constraints.maxWidth;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Ambient Candy Dots & Sprinkles
                        _buildBackgroundSprinkles(w, h),

                        // Main Vertical Content
                        Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 1. Top Section: 3 Floating Candies (Scaled Up)
                                SizedBox(
                                  height: h * 0.13,
                                  width: w,
                                  child: Stack(
                                    children: [
                                      // Top-Left: Floating Red Candy Bean
                                      Positioned(
                                        left: w * 0.05,
                                        top: 4.h + _floatAnim.value * 0.8,
                                        child: Transform.rotate(
                                          angle: -0.22,
                                          child: Image.asset(
                                            kCandyBeanRed,
                                            width: 86.w,
                                            height: 68.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      // Top-Center: Floating Yellow Candy Bean
                                      Positioned(
                                        left: w * 0.42,
                                        top: 0.h - _floatAnim.value,
                                        child: Transform.rotate(
                                          angle: 0.12,
                                          child: Image.asset(
                                            kCandyBeanYellow,
                                            width: 58.w,
                                            height: 66.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      // Top-Right: Floating Green Sugar Candy
                                      Positioned(
                                        right: w * 0.05,
                                        top: 2.h + _floatAnim.value,
                                        child: Transform.rotate(
                                          angle: 0.30,
                                          child: Image.asset(
                                            kCandyBeanGreen,
                                            width: 78.w,
                                            height: 84.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // 2. DODIS GODIS 3D Title Logo + Celebration Rays (Larger & Prominent)
                                ScaleTransition(
                                  scale: _pulseAnim,
                                  child: Image.asset(
                                    kTapScreenLogo,
                                    width: 365.w,
                                    height: h * 0.28,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                // 3. Subtitle: "The Sweetest Party Game!" (Bigger & Bolder)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: Text(
                                    kTheSweetestPartyGame,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.comicNeue(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF26190E),
                                      letterSpacing: 0.3,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white
                                              .withValues(alpha: 0.95),
                                          offset: const Offset(0, 1.5),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // 4. Center-Bottom: Assorted Candy Mountain / Pile (Bigger & Grand)
                                Transform.translate(
                                  offset: Offset(0, -_floatAnim.value * 0.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF332014)
                                              .withValues(alpha: 0.12),
                                          blurRadius: 32.r,
                                          offset: Offset(0, 18.h),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      kCandyMountain,
                                      width: 345.w,
                                      height: h * 0.44,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                // 5. Golden Pill "Tap to Play" Button (Reusable Widget)
                                TapToPlayButton(
                                  text: kTapToPlay,
                                  onPressed: _onTapPlay,
                                  gradientColors: const [
                                    Color(0xFFFFE072),
                                    Color(0xFFFFCA28),
                                    Color(0xFFFFB300),
                                  ],
                                  borderColor: const Color(0xFF2A180B),
                                  textColor: const Color(0xFF26190E),
                                  width: 320.w,
                                  height: 64.h,
                                  fontSize: 23.sp,
                                  borderWidth: 2.8,
                                ),

                                SizedBox(height: h * 0.015),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundSprinkles(double w, double h) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Left cyan speck
          Positioned(
            left: w * 0.06,
            top: h * 0.28,
            child: _buildDot(Color(0xFF00B4D8), 7.r),
          ),
          // Right yellow speck
          Positioned(
            right: w * 0.08,
            top: h * 0.32,
            child: _buildDot(Color(0xFFFFB703), 8.r),
          ),
          // Left pink sprinkle
          Positioned(
            left: w * 0.07,
            top: h * 0.44,
            child: _buildDot(Color(0xFFFF4D6D), 6.r),
          ),
          // Right purple sprinkle
          Positioned(
            right: w * 0.06,
            top: h * 0.46,
            child: _buildDot(Color(0xFF9D4EDD), 7.r),
          ),
          // Bottom-left green speck
          Positioned(
            left: w * 0.12,
            top: h * 0.58,
            child: _buildDot(Color(0xFF52B788), 7.r),
          ),
          // Bottom-right orange speck
          Positioned(
            right: w * 0.10,
            top: h * 0.60,
            child: _buildDot(Color(0xFFFB8500), 8.r),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
