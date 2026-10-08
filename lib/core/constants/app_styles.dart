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
