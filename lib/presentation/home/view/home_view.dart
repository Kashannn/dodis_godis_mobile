import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatefulWidget {
  const _HomeViewContent();

  @override
  State<_HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<_HomeViewContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _pulseAnim;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.98, end: 1.03).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _floatAnim = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showSettingsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: kHomePurplePrimary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.settings_rounded,
                    color: kHomePurplePrimary,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  kGameSettingsTitle,
                  style: kHomeSettingsHeaderStyle,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.rule_rounded, color: kHomePurplePrimary),
              title: Text(
                kSettingsRulesTitle,
                style: kHomeSettingsListTitleStyle,
              ),
              subtitle: Text(
                kSettingsRulesSubtitle,
                style: kHomeSettingsListSubtitleStyle,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                context.push(Routes.howToPlayScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_rounded, color: kHomePurplePrimary),
              title: Text(
                kSettingsPartyTitle,
                style: kHomeSettingsListTitleStyle,
              ),
              subtitle: Text(
                kSettingsPartySubtitle,
                style: kHomeSettingsListSubtitleStyle,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                context.push(Routes.createParty);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_rounded, color: kHomeChallengesAmber),
              title: Text(
                kSettingsChallengesTitle,
                style: kHomeSettingsListTitleStyle,
              ),
              subtitle: Text(
                kSettingsChallengesSubtitle,
                style: kHomeSettingsListSubtitleStyle,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                context.push(Routes.rules);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showStatsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: kHomePurplePrimary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    color: kHomePurplePrimary,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  kPartyGameStatsTitle,
                  style: kHomeSettingsHeaderStyle,
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    kStatsCandiesValue,
                    kStatsCandiesLabel,
                    kHomeCandyPink,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildStatItem(
                    kStatsPlayersValue,
                    kStatsPlayersLabel,
                    kHomePlayersBlue,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildStatItem(
                    kStatsChallengesValue,
                    kStatsChallengesLabel,
                    kHomeChallengesAmber,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: kHomePurplePrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                minimumSize: Size(double.infinity, 44.h),
              ),
              child: Text(
                kAwesomeButton,
                style: kHomeAwesomeBtnStyle,
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String val, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Text(
            val,
            style: GoogleFonts.comicNeue(
              fontSize: 17.sp,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: kHomeStatLabelStyle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kHomeBackgroundColor,
      safeBottom: true,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.25, 0.7, 1.0],
                colors: [
                  kHomeSkyBlueTop,
                  kHomeSkyBlueMid,
                  kHomeWarmIvory,
                  kHomeSoftLavender,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 6.h),

                  // 1. Top Bar: Settings & Stats
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Settings Gear Button
                        GestureDetector(
                          onTap: _showSettingsDialog,
                          child: Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: kHomePurpleDark,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: kHomePurpleDark.withValues(alpha: 0.3),
                                  blurRadius: 8.r,
                                  offset: Offset(0, 3.h),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),

                        // Stats Bar-Chart Button
                        GestureDetector(
                          onTap: _showStatsDialog,
                          child: Container(
                            width: 46.w,
                            height: 46.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kHomePurpleDark.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8.r,
                                  offset: Offset(0, 3.h),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.bar_chart_rounded,
                                  color: kHomePurpleDark,
                                  size: 20,
                                ),
                                Text(
                                  kStatsButtonLabel,
                                  style: kHomeStatsBtnTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. 3D Dodis Godis Title Logo
                  SizedBox(height: 4.h),
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnim.value,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      kTapScreenLogo,
                      width: 250.w,
                      height: 85.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Subtitle bullets: Roll • Move • Collect Candy • Do Challenges • Win!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      kHomeGameplaySteps,
                      textAlign: TextAlign.center,
                      style: kHomeSubtitleBulletsStyle,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // 3. Hero Section: Kids around board + "Start Game" Button Overlay
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // Kids Playing Board Game 3D Artwork
                        AnimatedBuilder(
                          animation: _floatAnim,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatAnim.value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxHeight: 250.h,
                            ),
                            child: Image.asset(
                              kHomeHeroKids,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Start Game Glowing Pill Button
                        Positioned(
                          bottom: -24.h,
                          child: GestureDetector(
                            onTap: () => context.push(Routes.createParty),
                            child: AnimatedBuilder(
                              animation: _pulseAnim,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnim.value,
                                  child: child,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      kHomeYellowGradientStart,
                                      kHomeYellowGradientMid,
                                      kHomeYellowGradientEnd,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(32.r),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kHomeYellowGradientEnd.withValues(alpha: 0.5),
                                      blurRadius: 16.r,
                                      offset: Offset(0, 6.h),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      blurRadius: 4.r,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Play icon button
                                    Container(
                                      width: 36.w,
                                      height: 36.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: kHomeOrangeDeep,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    // Text & Subtitle
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              kStartGame,
                                              style: kHomeStartGameBtnTitleStyle,
                                            ),
                                            SizedBox(width: 6.w),
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          kStartGameSubtitle,
                                          style: kHomeStartGameBtnSubtitleStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Space under Start Game button
                  SizedBox(height: 38.h),

                  // 4. Four Info / Stat Cards Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0).withValues(alpha: 0.8),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // 1. Total Candies
                          Expanded(
                            child: _buildSmallInfoCard(
                              icon: Icons.cake_rounded,
                              iconColor: kHomeCandyPink,
                              bgColor: kHomeCandyPinkBg,
                              title: kHomeTotalCandiesTitle,
                              val: kHomeTotalCandiesCount,
                              subtitle: kHomeTotalCandiesSubtitle,
                              onTap: null,
                            ),
                          ),
                          _buildDivider(),

                          // 2. Players
                          Expanded(
                            child: _buildSmallInfoCard(
                              icon: Icons.groups_rounded,
                              iconColor: kHomePlayersBlue,
                              bgColor: kHomePlayersBlueBg,
                              title: kHomePlayersTitle,
                              val: kHomePlayersRange,
                              subtitle: kHomePlayersSubtitle,
                              onTap: () => context.push(Routes.createParty),
                            ),
                          ),
                          _buildDivider(),

                          // 3. Challenges
                          Expanded(
                            child: _buildSmallInfoCard(
                              icon: Icons.emoji_events_rounded,
                              iconColor: kHomeChallengesAmber,
                              bgColor: kHomeChallengesAmberBg,
                              title: kHomeChallengesTitle,
                              val: kHomeChallengesCount,
                              subtitle: kHomeChallengesSubtitle,
                              onTap: () => context.push(Routes.rules),
                            ),
                          ),
                          _buildDivider(),

                          // 4. Game Mode
                          Expanded(
                            child: _buildSmallInfoCard(
                              icon: Icons.casino_rounded,
                              iconColor: kHomeModePurple,
                              bgColor: kHomeModePurpleBg,
                              title: kHomeGameModeTitle,
                              val: kHomeGameModeValue,
                              subtitle: kHomeGameModeSubtitle,
                              onTap: () => context.push(Routes.howToPlayScreen),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // 5. Two Feature Cards Side-by-Side: "How to Play" & "Challenges"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Card: How to Play
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.push(Routes.howToPlayScreen),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: kHomeHowToPlayBg,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: kHomeHowToPlayBorder,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: kHomeHowToPlayBtnGreen.withValues(alpha: 0.08),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kHomeHowToPlayTitle,
                                    style: kHomeHowToPlayTitleStyle,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    kHomeHowToPlaySubtitle,
                                    style: kHomeHowToPlaySubtitleStyle,
                                  ),
                                  SizedBox(height: 10.h),
                                  // Image: 3D Rule Book
                                  Center(
                                    child: Image.asset(
                                      kHomeRuleBook,
                                      height: 72.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  // Button: View Guide ->
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 7.h),
                                    decoration: BoxDecoration(
                                      color: kHomeHowToPlayBtnGreen,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          kHomeViewGuideAction,
                                          style: kHomeHowToPlayBtnStyle,
                                        ),
                                        SizedBox(width: 4.w),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        // Right Card: Challenges
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.push(Routes.rules),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: kHomeChallengesCardBg,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: kHomeChallengesCardBorder,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: kHomeChallengesBtnPurple.withValues(alpha: 0.08),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kHomeChallengesCardTitle,
                                    style: kHomeChallengesTitleStyle,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    kHomeChallengesCardSubtitle,
                                    style: kHomeChallengesSubtitleStyle,
                                  ),
                                  SizedBox(height: 10.h),
                                  // Image: 3D Target Bullseye
                                  Center(
                                    child: Image.asset(
                                      kHomeChallengeTarget,
                                      height: 72.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  // Button: See Challenges ->
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 7.h),
                                    decoration: BoxDecoration(
                                      color: kHomeChallengesBtnPurple,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          kHomeSeeChallengesAction,
                                          style: kHomeChallengesBtnStyle,
                                        ),
                                        SizedBox(width: 4.w),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // 6. Bottom Wide Card: "Player Setup"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: GestureDetector(
                      onTap: () => context.push(Routes.createParty),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: kHomePlayerSetupBorder.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 3D Player Pawns with Crown
                            Image.asset(
                              kHomePlayerPawns,
                              width: 58.w,
                              height: 52.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 10.w),

                            // Title & Description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kHomePlayerSetupTitle,
                                    style: kHomePlayerSetupTitleStyle,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    kHomePlayerSetupSubtitle,
                                    style: kHomePlayerSetupSubtitleStyle,
                                  ),
                                ],
                              ),
                            ),

                            // "Edit Players ->" Pill Button
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: kHomeModePurpleBg,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    kHomeEditPlayersAction,
                                    style: kHomePlayerSetupBtnStyle,
                                  ),
                                  SizedBox(width: 3.w),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kHomePurpleDark,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // 7. Playful Festive Banner: "✨ More Candy = More Fun! ✨"
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          kHomeRibbonPurpleStart,
                          kHomeRibbonPurpleEnd,
                          kHomeRibbonPurpleStart,
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(26.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kHomeRibbonPurpleStart.withValues(alpha: 0.3),
                          blurRadius: 10.r,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        kHomeMoreCandyMoreFun,
                        style: kHomeRibbonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 38.h,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildSmallInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String val,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 15.sp,
                    color: iconColor,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: kHomeSmallCardTitleStyle,
              ),
              Text(
                val,
                style: kHomeSmallCardValueStyle,
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: kHomeSmallCardSubtitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
