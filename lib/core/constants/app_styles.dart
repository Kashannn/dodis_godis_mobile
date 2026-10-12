import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

// ── Splash & Brand Styles ──
final TextStyle kSplashTitleStyle = GoogleFonts.poppins(
  fontSize: 32.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 1.5,
  color: kPrimaryTextColor,
);

final TextStyle kBadgeTagStyle = GoogleFonts.manrope(
  fontSize: 12.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFFB76E00),
);

final TextStyle kTaglineStyle = GoogleFonts.manrope(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: kSecondaryTextColor,
  fontStyle: FontStyle.italic,
);

final TextStyle kSplashContainsStyle = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.w900,
  height: 1.05,
  letterSpacing: -0.5,
  color: const Color(0xFFD31027),
);

final TextStyle kSplashSubtitleStyle = GoogleFonts.poppins(
  fontSize: 12.5.sp,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.italic,
  color: const Color(0xFF1E293B),
);

final TextStyle kSplashBannerStyle = GoogleFonts.poppins(
  fontSize: 10.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.8,
  color: const Color(0xFF3B1E28),
);

final TextStyle kSplashTapPromptStyle = GoogleFonts.poppins(
  fontSize: 11.sp,
  fontWeight: FontWeight.w800,
  letterSpacing: 1.2,
  color: Colors.white,
);

// ── Headings ──
final TextStyle kHeaderTitleStyle = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: -0.5,
  color: kPrimaryTextColor,
);

final TextStyle kHeadingLarge = GoogleFonts.poppins(
  fontSize: 26.sp,
  fontWeight: FontWeight.w800,
  color: kPrimaryTextColor,
  letterSpacing: -0.5,
);

final TextStyle kHeadingHero = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.w900,
  color: kWhite,
  letterSpacing: -0.3,
);

final TextStyle kHeadingMedium = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.w800,
  color: kPrimaryTextColor,
);

final TextStyle kHeadingSmall = GoogleFonts.poppins(
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
  color: kPrimaryTextColor,
);

final TextStyle kHeadingXSmall = GoogleFonts.poppins(
  fontSize: 13.5.sp,
  fontWeight: FontWeight.w700,
  color: kPrimaryTextColor,
);

final TextStyle kSectionHeadingStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.6,
  color: kPrimaryTextColor,
);

final TextStyle kCategoryTagStyle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
  color: kPrimaryTextColor,
);

// ── Body & Text ──
final TextStyle kBodyLarge = GoogleFonts.manrope(
  fontSize: 15.sp,
  fontWeight: FontWeight.w500,
  color: kPrimaryTextColor,
);

final TextStyle kBodyMedium = GoogleFonts.manrope(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: kSecondaryTextColor,
);

final TextStyle kBodySmall = GoogleFonts.manrope(
  fontSize: 11.5.sp,
  fontWeight: FontWeight.w500,
  color: kSecondaryTextColor,
);

final TextStyle kCaption = GoogleFonts.manrope(
  fontSize: 10.sp,
  fontWeight: FontWeight.w500,
  color: kSecondaryTextColor,
);

final TextStyle kHeroDescriptionStyle = GoogleFonts.manrope(
  fontSize: 12.5.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white.withValues(alpha: 0.85),
  height: 1.4,
);

// ── Buttons ──
final TextStyle kButtonLargeStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
  color: kWhite,
);

final TextStyle kButtonMediumStyle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
  color: kWhite,
);

final TextStyle kButtonSmallStyle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w700,
  color: kWhite,
);

final TextStyle kOutlineButtonTextStyle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: kPrimaryTextColor,
);

// ── Badges, Chips & Highlights ──
final TextStyle kMiniBadgeStyle = GoogleFonts.poppins(
  fontSize: 9.sp,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

final TextStyle kHeroBadgeStyle = GoogleFonts.poppins(
  fontSize: 10.sp,
  fontWeight: FontWeight.w800,
  color: const Color(0xFF573B00),
);

final TextStyle kModeTitleStyle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w700,
);

final TextStyle kModeDescStyle = GoogleFonts.manrope(
  fontSize: 10.5.sp,
  color: kSecondaryTextColor,
);

final TextStyle kChipTextStyle = GoogleFonts.poppins(
  fontSize: 11.5.sp,
  fontWeight: FontWeight.w600,
);

// ── Yatzy Protocol & Dice ──
final TextStyle kProtocolHeaderStyle = GoogleFonts.poppins(
  fontSize: 11.5.sp,
  fontWeight: FontWeight.w800,
  color: kWhite,
);

final TextStyle kProtocolRowLabelStyle = GoogleFonts.manrope(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
  color: kPrimaryTextColor,
);

final TextStyle kProtocolScoreStyle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w700,
  color: kPrimaryTextColor,
);

final TextStyle kProtocolTotalLabelStyle = GoogleFonts.poppins(
  fontSize: 13.sp,
  fontWeight: FontWeight.w900,
  color: const Color(0xFF7E4B00),
);

final TextStyle kDicePipNumberStyle = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.w800,
);

final TextStyle kSaveBadgeStyle = GoogleFonts.poppins(
  fontSize: 7.5.sp,
  fontWeight: FontWeight.w800,
  color: kWhite,
);

// ── Date Cards ──
final TextStyle kDateQuestionStyle = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.w700,
  color: kPrimaryTextColor,
  height: 1.4,
);

final TextStyle kDateBadgeStyle = GoogleFonts.poppins(
  fontSize: 11.sp,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

// ── Room & TV ──
final TextStyle kRoomCodeStyle = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 1.5,
  color: kPrimaryTextColor,
);

// ── Home Screen Styles ──
final TextStyle kHomeSettingsHeaderStyle = GoogleFonts.comicNeue(
  fontSize: 20.sp,
  fontWeight: FontWeight.w900,
  color: kHomePurpleDeep,
);

final TextStyle kHomeSettingsListTitleStyle = GoogleFonts.comicNeue(
  fontSize: 15.sp,
  fontWeight: FontWeight.w800,
);

final TextStyle kHomeSettingsListSubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

final TextStyle kHomeStatLabelStyle = GoogleFonts.comicNeue(
  fontSize: 11.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFF424242),
);

final TextStyle kHomeAwesomeBtnStyle = GoogleFonts.comicNeue(
  fontSize: 16.sp,
  fontWeight: FontWeight.w900,
);

final TextStyle kHomeStatsBtnTextStyle = GoogleFonts.comicNeue(
  fontSize: 9.sp,
  fontWeight: FontWeight.w900,
  color: kHomePurpleDark,
);

final TextStyle kHomeSubtitleBulletsStyle = GoogleFonts.comicNeue(
  fontSize: 12.5.sp,
  fontWeight: FontWeight.w900,
  color: kHomeNavyBlue,
  letterSpacing: 0.2,
);

final TextStyle kHomeStartGameBtnTitleStyle = GoogleFonts.comicNeue(
  fontSize: 22.sp,
  fontWeight: FontWeight.w900,
  color: Colors.white,
  shadows: [
    Shadow(
      color: kHomeOrangeShadow.withValues(alpha: 0.6),
      blurRadius: 3,
      offset: const Offset(1, 1),
    ),
  ],
);

final TextStyle kHomeStartGameBtnSubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 10.5.sp,
  fontWeight: FontWeight.w700,
  color: Colors.white.withValues(alpha: 0.95),
);

final TextStyle kHomeSmallCardTitleStyle = GoogleFonts.comicNeue(
  fontSize: 10.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFF616161),
);

final TextStyle kHomeSmallCardValueStyle = GoogleFonts.comicNeue(
  fontSize: 14.5.sp,
  fontWeight: FontWeight.w900,
  color: const Color(0xFF212121),
);

final TextStyle kHomeSmallCardSubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 8.5.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFF757575),
);

final TextStyle kHomeHowToPlayTitleStyle = GoogleFonts.comicNeue(
  fontSize: 16.sp,
  fontWeight: FontWeight.w900,
  color: kHomeHowToPlayDarkGreen,
);

final TextStyle kHomeHowToPlaySubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 11.sp,
  fontWeight: FontWeight.w700,
  color: kHomeHowToPlayMidGreen,
);

final TextStyle kHomeHowToPlayBtnStyle = GoogleFonts.comicNeue(
  fontSize: 12.sp,
  fontWeight: FontWeight.w900,
  color: Colors.white,
);

final TextStyle kHomeChallengesTitleStyle = GoogleFonts.comicNeue(
  fontSize: 16.sp,
  fontWeight: FontWeight.w900,
  color: kHomeChallengesDarkPurple,
);

final TextStyle kHomeChallengesSubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 11.sp,
  fontWeight: FontWeight.w700,
  color: kHomeChallengesBtnPurple,
);

final TextStyle kHomeChallengesBtnStyle = GoogleFonts.comicNeue(
  fontSize: 12.sp,
  fontWeight: FontWeight.w900,
  color: Colors.white,
);

final TextStyle kHomePlayerSetupTitleStyle = GoogleFonts.comicNeue(
  fontSize: 15.5.sp,
  fontWeight: FontWeight.w900,
  color: kHomeNavyBlue,
);

final TextStyle kHomePlayerSetupSubtitleStyle = GoogleFonts.comicNeue(
  fontSize: 11.5.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFF616161),
);

final TextStyle kHomePlayerSetupBtnStyle = GoogleFonts.comicNeue(
  fontSize: 12.sp,
  fontWeight: FontWeight.w900,
  color: kHomePurpleDark,
);

final TextStyle kHomeRibbonTextStyle = GoogleFonts.comicNeue(
  fontSize: 14.5.sp,
  fontWeight: FontWeight.w900,
  color: Colors.white,
  letterSpacing: 0.5,
);

