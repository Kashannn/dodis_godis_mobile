import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../dodis_game/widgets/multifunctional_board_widget.dart';
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
  late final Animation<double> _scalePulseAnim;
  bool _showBackside = false;

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

    _scalePulseAnim = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
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
      backgroundColor: const Color(0xFFFAF4E6),
      safeBottom: true,
      appBar: AppCustomAppBar(
        title: 'How to Play',
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFDF8),
              Color(0xFFFAF3E5),
              Color(0xFFF6ECE0),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Game Header Badge & Title
                _buildGameHeader(),
                SizedBox(height: 12.h),

                // 2. Quick Game Stats Pills
                _buildQuickStatsStrip(),
                SizedBox(height: 14.h),

                // 3. Double-Sided Switcher Bar
                _buildSideSwitcher(),
                SizedBox(height: 14.h),

                // 4. Main Showcase (Front Wheel OR Back Multifunctional Board)
                if (!_showBackside) ...[
                  // 3D Floating Wheel with Transparent Candies Around It
                  _buildFloating3DWheel(),
                  SizedBox(height: 20.h),

                  // Section Title: Game Steps
                  _buildSectionHeader(
                    badge: 'STEP-BY-STEP RULES',
                    title: 'How A Turn Works',
                    subtitle: 'Follow the 6 steps around the candy circle track',
                  ),
                  SizedBox(height: 12.h),

                  // 6 Tactile Game Quest Cards
                  _buildGameStepCard(
                    stepNumber: '01',
                    badge: 'SETUP',
                    title: 'Place The Candies',
                    description:
                        'Scatter the 42 candy chips on all blank circles around the outer track. The illustrated circles are your challenges!',
                    accentColor: const Color(0xFFFF9800),
                    iconEmoji: '🍬',
                  ),
                  _buildGameStepCard(
                    stepNumber: '02',
                    badge: 'PLAYER HUB',
                    title: 'Choose Your Cup',
                    description:
                        'Each player picks their favorite candy container color and places it on a station hub.',
                    accentColor: const Color(0xFF43A047),
                    iconEmoji: '🍧',
                  ),
                  _buildGameStepCard(
                    stepNumber: '03',
                    badge: 'YOUR TURN',
                    title: 'Roll & Move Clockwise',
                    description:
                        'Roll the edible candy dice and move your cup forward clockwise by the exact number rolled.',
                    accentColor: const Color(0xFF0288D1),
                    iconEmoji: '🎲',
                  ),
                  _buildGameStepCard(
                    stepNumber: '04',
                    badge: 'DUEL TIME',
                    title: 'Face Crazy Challenges',
                    description:
                        'Landed on a challenge? Pick an opponent to duel in drops, spins, taste tests, or trivia!',
                    accentColor: const Color(0xFFFF5722),
                    iconEmoji: '🎯',
                  ),
                  _buildGameStepCard(
                    stepNumber: '05',
                    badge: 'CANDY PRIZE',
                    title: 'Win The Candy Reward',
                    description:
                        'Win the duel to stash the candy into your cup! Landed on a blank plate? Pick up the candy directly!',
                    accentColor: const Color(0xFFE91E63),
                    iconEmoji: '🏆',
                  ),
                  _buildGameStepCard(
                    stepNumber: '06',
                    badge: 'VICTORY',
                    title: 'Last Candy Takes All!',
                    description:
                        'Have fun! The champion who claims the very last piece of candy on the board wins the entire game!',
                    accentColor: const Color(0xFFFFB300),
                    iconEmoji: '👑',
                  ),
                ] else ...[
                  // Back Side Multifunctional Board Widget
                  const MultifunctionalBoardWidget(),
                  SizedBox(height: 18.h),

                  // Back Side Highlights
                  _buildSectionHeader(
                    badge: '3-IN-1 BACK SIDE',
                    title: 'All Offline Games On The Back',
                    subtitle: 'Designed to play with or without the app',
                  ),
                  SizedBox(height: 12.h),

                  _buildGameStepCard(
                    stepNumber: 'A',
                    badge: 'DICE GAME',
                    title: 'Yatzy Score Sheet',
                    description:
                        'Roll 5 candy dice and record your scores directly in the pre-printed 18-row Yatzy score sheet.',
                    accentColor: const Color(0xFF2E7D32),
                    iconEmoji: '📝',
                  ),
                  _buildGameStepCard(
                    stepNumber: 'B',
                    badge: 'CLASSIC',
                    title: 'Backgammon (24 Points)',
                    description:
                        'Classic 24 triangular points with 15 red vs 15 white candies, 4 dice, and center doubling cube.',
                    accentColor: const Color(0xFFD84315),
                    iconEmoji: '🎲',
                  ),
                  _buildGameStepCard(
                    stepNumber: 'C',
                    badge: 'CONNECT 4',
                    title: 'Four in a Row (7x6 Grid)',
                    description:
                        'Centered circular grid for 21 red vs 21 white candies (exactly 42 candy chips from the bag!).',
                    accentColor: const Color(0xFF0288D1),
                    iconEmoji: '🔴',
                  ),
                  _buildGameStepCard(
                    stepNumber: 'D',
                    badge: 'TRIVIA COMPATIBLE',
                    title: 'Trivial Pursuit Wedges',
                    description:
                        'The 42 candy chips in 6 colors double as pie wedges for all 6 classic trivia categories.',
                    accentColor: const Color(0xFF8E24AA),
                    iconEmoji: '🍰',
                  ),
                ],

                SizedBox(height: 28.h),

                // 5. Juicy Animated "Let's Play" Action Button
                ScaleTransition(
                  scale: _scalePulseAnim,
                  child: TapToPlayButton(
                    text: "LET'S PLAY! 🎲",
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
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top game header banner
  Widget _buildGameHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB300), Color(0xFFF57C00)],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB300).withValues(alpha: 0.35),
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🇸🇪', style: TextStyle(fontSize: 14)),
              SizedBox(width: 6.w),
              Text(
                'OFFICIAL GAMEPLAY GUIDE',
                style: GoogleFonts.comicNeue(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'DODIS GODIS SPELET',
          style: GoogleFonts.comicNeue(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
            color: const Color(0xFF2E1C0C),
          ),
        ),
        Text(
          'The tastiest path to connection & hilarious mini-games!',
          textAlign: TextAlign.center,
          style: GoogleFonts.comicNeue(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF795548),
          ),
        ),
      ],
    );
  }

  /// Quick badges row
  Widget _buildQuickStatsStrip() {
    final stats = [
      ('🎲', '5 Candy Dice'),
      ('🍬', '42 Candies'),
      ('🎯', '18 Challenges'),
      ('👥', '2–6 Players'),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.w,
      runSpacing: 6.h,
      children: stats.map((stat) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE0D5C1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(stat.$1, style: TextStyle(fontSize: 13.sp)),
              SizedBox(width: 5.w),
              Text(
                stat.$2,
                style: GoogleFonts.comicNeue(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF4E342E),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Double-sided switcher button
  Widget _buildSideSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFD7CCC8), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showBackside = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(vertical: 9.h),
                decoration: BoxDecoration(
                  gradient: !_showBackside
                      ? const LinearGradient(
                          colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                        )
                      : null,
                  color: _showBackside ? Colors.transparent : null,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: !_showBackside
                      ? [
                          BoxShadow(
                            color: const Color(0xFFE65100)
                                .withValues(alpha: 0.35),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.donut_large_rounded,
                        size: 15.sp,
                        color: !_showBackside
                            ? Colors.white
                            : const Color(0xFF6D4C41),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Front (Dodis Wheel)',
                        style: GoogleFonts.comicNeue(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: !_showBackside
                              ? Colors.white
                              : const Color(0xFF6D4C41),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showBackside = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(vertical: 9.h),
                decoration: BoxDecoration(
                  gradient: _showBackside
                      ? const LinearGradient(
                          colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
                        )
                      : null,
                  color: !_showBackside ? Colors.transparent : null,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: _showBackside
                      ? [
                          BoxShadow(
                            color: const Color(0xFF2E7D32)
                                .withValues(alpha: 0.35),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flip_camera_android_rounded,
                        size: 15.sp,
                        color: _showBackside
                            ? Colors.white
                            : const Color(0xFF6D4C41),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Back (3-in-1 Board)',
                        style: GoogleFonts.comicNeue(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: _showBackside
                              ? Colors.white
                              : const Color(0xFF6D4C41),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 3D Floating Wheel with Scattered Transparent Candies
  Widget _buildFloating3DWheel() {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // 1. Ambient Glow Aura
              Container(
                width: 270.w,
                height: 270.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.22),
                      blurRadius: 36.r,
                      spreadRadius: 10.r,
                    ),
                  ],
                ),
              ),

              // 2. The 3D Transparent Board Image
              Image.asset(
                kHowToPlayBoard,
                width: 260.w,
                height: 260.w,
                fit: BoxFit.contain,
              ),

              // 3. Playful Floating Transparent Candies Around the Board
              Positioned(
                top: -8.h,
                left: 10.w,
                child: Transform.rotate(
                  angle: -0.25,
                  child: Image.asset(
                    kCandyBeanYellow,
                    width: 44.w,
                    height: 44.w,
                  ),
                ),
              ),
              Positioned(
                top: 4.h,
                right: 8.w,
                child: Transform.rotate(
                  angle: 0.35,
                  child: Image.asset(
                    kCandyBeanRed,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
              ),
              Positioned(
                bottom: -4.h,
                left: 14.w,
                child: Transform.rotate(
                  angle: 0.3,
                  child: Image.asset(
                    kCandyBeanGreen,
                    width: 42.w,
                    height: 42.w,
                  ),
                ),
              ),
              Positioned(
                bottom: 2.h,
                right: 12.w,
                child: Transform.rotate(
                  angle: -0.3,
                  child: Image.asset(
                    kCandyDice,
                    width: 38.w,
                    height: 38.w,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Section Header
  Widget _buildSectionHeader({
    required String badge,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6D4C41).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            badge,
            style: GoogleFonts.comicNeue(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color: const Color(0xFF4E342E),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: GoogleFonts.comicNeue(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF2E1C0C),
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.comicNeue(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8D6E63),
          ),
        ),
      ],
    );
  }

  /// Tactile Game Quest Step Card
  Widget _buildGameStepCard({
    required String stepNumber,
    required String badge,
    required String title,
    required String description,
    required Color accentColor,
    required String iconEmoji,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.35),
          width: 1.6,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.10),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Number & Emoji Hex/Circle Badge
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.2),
                  accentColor.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: accentColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  iconEmoji,
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  stepNumber,
                  style: GoogleFonts.comicNeue(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w900,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Right Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        badge,
                        style: GoogleFonts.comicNeue(
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  title,
                  style: GoogleFonts.comicNeue(
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF26190E),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: GoogleFonts.comicNeue(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF5D4037),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
