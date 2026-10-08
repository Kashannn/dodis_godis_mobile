import 'package:flutter/material.dart';

// Brand & Base Colors
const Color kPrimaryColor = Color(0xFFD63031); // Candy Red
const Color kPrimaryDark = Color(0xFFB71540);
const Color kBackgroundColor = Color(0xFFFDFBF7); // Warm paper cream
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF1B1A1F);
const Color kPrimaryTextColor = Color(0xFF2C2C54);
const Color kSecondaryTextColor = Color(0xFF706FD3);
const Color kBorderColor = Color(0xFFECEFF1);

// Candy Palette (from Godis sketches)
const Color kCandyRed = Color(0xFFFF5252);
const Color kCandyYellow = Color(0xFFFFB142);
const Color kCandyGreen = Color(0xFF2ED573);
const Color kCandyBlue = Color(0xFF3867D6);
const Color kCandyPurple = Color(0xFF8854D0);
const Color kCandyOrange = Color(0xFFFF793F);
const Color kCandyPink = Color(0xFFFF6B81);

// Board Theme Colors (from multifunctional board sketches)
const Color kBoardWood = Color(0xFF8B5E3C);
const Color kBoardGreen = Color(0xFF26734D);
const Color kBoardGold = Color(0xFFE58E26);

// Party & Shot Mode
const Color kShotModeColor = Color(0xFFEA2027);
const Color kCandyModeColor = Color(0xFF009432);

// Gradients
const LinearGradient kCandyGradient = LinearGradient(
  colors: [Color(0xFFFF5252), Color(0xFFFF793F), Color(0xFFFFB142)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kPartyGradient = LinearGradient(
  colors: [Color(0xFF8854D0), Color(0xFF3867D6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kHeroCardGradient = LinearGradient(
  colors: [Color(0xFF2C2C54), Color(0xFF474787)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
