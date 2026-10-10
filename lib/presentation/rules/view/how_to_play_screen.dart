import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../splash/widgets/tap_to_play_button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onNext() {
    context.push(Routes.tapToPlay);
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: const Color(0xFFFAF5E8),
      safeBottom: true,
      appBar: AppCustomAppBar(
        title: kHowToPlayTitle,
        titleColor: const Color(0xFF1B1B2F),
        iconColor: const Color(0xFF1B1B2F),
        onBackTap: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            context.go(Routes.home);
          }
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.1,
            colors: [
              Color(0xFFFFFDF8),
              Color(0xFFFAF5E8),
              Color(0xFFF3ECE0),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
            child: Column(
              children: [
                // 1. 3D Gameboard Wheel Illustration
                AnimatedBuilder(
                  animation: _floatAnim,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatAnim.value),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF332014)
                                  .withValues(alpha: 0.10),
                              blurRadius: 24.r,
                              offset: Offset(0, 12.h),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          kHowToPlayBoard,
                          width: 260.w,
                          height: 260.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 14.h),

                // 2. Numbered Rules List
                _buildRuleItem(
                  number: '1',
                  color: const Color(0xFFFFA000), // Vibrant Orange
                  text: kRule1PlaceCandy,
                ),
                _buildRuleItem(
                  number: '2',
                  color: const Color(0xFF43A047), // Green
                  text: kRule2ChooseHolder,
                ),
                _buildRuleItem(
                  number: '3',
                  color: const Color(0xFF03A9F4), // Sky Blue
                  text: kRule3RollDice,
                ),
                _buildRuleItem(
                  number: '4',
                  color: const Color(0xFFFF7043), // Deep Orange / Coral
                  text: kRule4DoChallenge,
                ),
                _buildRuleItem(
                  number: '5',
                  color: const Color(0xFF4CAF50), // Candy Green
                  text: kRule5PickOpponent,
                ),
                _buildRuleItem(
                  number: '6',
                  color: const Color(0xFFEF5350), // Berry Red / Coral
                  text: kRule6GetLastCandy,
                ),

                SizedBox(height: 40.h),

                // 3. Reusable "Next" Pill Button with Green Gradient
                TapToPlayButton(
                  text: kNext,
                  onPressed: _onNext,
                  gradientColors: const [
                    Color(0xFF66BB6A),
                    Color(0xFF43A047),
                    Color(0xFF2E7D32),
                  ],
                  borderColor: const Color(0xFF1B4D20),
                  textColor: Colors.white,
                  width: 330.w,
                  height: 60.h,
                  fontSize: 22.sp,
                  borderWidth: 2.6,
                ),

                SizedBox(height: 14.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem({
    required String number,
    required Color color,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Number Circle Badge
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 6.r,
                  offset: Offset(0, 2.5.h),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.comicNeue(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          // Rule Description Text
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF26190E),
                height: 1.25,
                letterSpacing: 0.15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
