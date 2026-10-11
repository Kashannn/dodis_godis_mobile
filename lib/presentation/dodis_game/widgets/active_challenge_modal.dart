import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../data/models/challenge_model.dart';
import '../../splash/widgets/tap_to_play_button.dart';
import '../bloc/dodis_game_state.dart';

class ActiveChallengeModal extends StatelessWidget {
  final ChallengeModel challenge;
  final List<GamePlayer> allPlayers;
  final GamePlayer currentPlayer;
  final String? selectedOpponent;
  final ValueChanged<String> onSelectOpponent;
  final ValueChanged<bool> onCompleteChallenge;

  const ActiveChallengeModal({
    super.key,
    required this.challenge,
    required this.allPlayers,
    required this.currentPlayer,
    required this.selectedOpponent,
    required this.onSelectOpponent,
    required this.onCompleteChallenge,
  });

  @override
  Widget build(BuildContext context) {
    final opponents = allPlayers.where((p) => p.id != currentPlayer.id).toList();

    // Find the currently selected opponent player object
    final chosenOpponent = opponents.firstWhere(
      (p) => p.name == selectedOpponent,
      orElse: () => opponents.isNotEmpty ? opponents.first : currentPlayer,
    );

    final currentHolderColor = currentPlayer.holderColor ?? kHolderBlue;
    final opponentHolderColor = chosenOpponent.holderColor ?? kHolderRed;

    return Container(
      constraints: BoxConstraints(maxHeight: 740.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        border: Border.all(
          color: const Color(0xFFFFD54F),
          width: 2.8,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8D6E63).withValues(alpha: 0.3),
            blurRadius: 28.r,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle pill
            Center(
              child: Container(
                width: 44.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD7CCC8),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // 1. Header with Swedish Badge & Reward Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Swedish "UTMANING" Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7043),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF7043).withValues(alpha: 0.35),
                        blurRadius: 6.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🎯 '),
                      Text(
                        'UTMANING',
                        style: GoogleFonts.comicNeue(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Candy Reward Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFFFFB74D),
                      width: 1.6,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🍬 '),
                      Text(
                        '1 Godis',
                        style: GoogleFonts.comicNeue(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // Challenge Title
            Text(
              challenge.title,
              style: GoogleFonts.comicNeue(
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              challenge.subtitle,
              style: GoogleFonts.comicNeue(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0288D1),
              ),
            ),

            SizedBox(height: 10.h),

            Image.asset(
              challenge.imageAsset,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => SizedBox(
                height: 200.h,
                child: Center(
                  child: Icon(
                    challenge.icon,
                    size: 54.sp,
                    color: challenge.accentColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // 3. Duel Section: Challenger VS Challenged Player
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: const Color(0xFFFFE082),
                  width: 1.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4A373).withValues(alpha: 0.18),
                    blurRadius: 10.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left: Current Player (Challenger)
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: currentHolderColor,
                              width: 2.8,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              kPlayerAvatarList[
                                  currentPlayer.avatarIndex % kPlayerAvatarList.length],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          currentPlayer.name,
                          style: GoogleFonts.comicNeue(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.5.h),
                          decoration: BoxDecoration(
                            color: currentHolderColor.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Challenger',
                            style: GoogleFonts.comicNeue(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w800,
                              color: currentHolderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Center: Comic "VS" Duel Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5252), Color(0xFFFF1744)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF1744).withValues(alpha: 0.45),
                          blurRadius: 8.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'VS',
                      style: GoogleFonts.comicNeue(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Right: Chosen Opponent (Challenged)
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: opponentHolderColor,
                              width: 2.8,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              kPlayerAvatarList[
                                  chosenOpponent.avatarIndex % kPlayerAvatarList.length],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          chosenOpponent.name,
                          style: GoogleFonts.comicNeue(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.5.h),
                          decoration: BoxDecoration(
                            color: opponentHolderColor.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Challenged',
                            style: GoogleFonts.comicNeue(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w800,
                              color: opponentHolderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 4. Opponent Selector Carousel
            if (opponents.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Text(
                'Choose your rival to challenge:',
                style: GoogleFonts.comicNeue(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF475569),
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                height: 68.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: opponents.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (ctx, index) {
                    final opp = opponents[index];
                    final isSelected = selectedOpponent == opp.name;
                    final oppColor = opp.holderColor ?? kHolderBlue;

                    return GestureDetector(
                      onTap: () => onSelectOpponent(opp.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? oppColor.withValues(alpha: 0.18)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected ? oppColor : const Color(0xFFE2E8F0),
                            width: isSelected ? 2.4 : 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 34.w,
                              height: 34.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: oppColor, width: 2),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  kPlayerAvatarList[
                                      opp.avatarIndex % kPlayerAvatarList.length],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              opp.name,
                              style: GoogleFonts.comicNeue(
                                fontSize: 13.5.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w900
                                    : FontWeight.w700,
                                color: isSelected
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            SizedBox(height: 10.h),

            // 5. Challenge Instructions in Candy Parchment
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E7),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: const Color(0xFFFFECB3),
                  width: 1.4,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📜 ', style: TextStyle(fontSize: 16.sp)),
                  Expanded(
                    child: Text(
                      challenge.instruction,
                      style: GoogleFonts.comicNeue(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF334155),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 6. Action Buttons: "Won Challenge!" vs "Failed"
            Row(
              children: [
                // Green "Won Challenge! 🍬" Button
                Expanded(
                  flex: 5,
                  child: TapToPlayButton(
                    text: 'Won Challenge! 🍬',
                    height: 52.h,
                    fontSize: 18.sp,
                    gradientColors: const [
                      Color(0xFF45D461),
                      Color(0xFF28B744),
                      Color(0xFF1A9331),
                    ],
                    borderColor: const Color(0xFF116522),
                    textColor: Colors.white,
                    onPressed: () => onCompleteChallenge(true),
                  ),
                ),
                SizedBox(width: 8.w),

                // Outline "Failed 😅" Button
                Expanded(
                  flex: 3,
                  child: OutlinedButton(
                    onPressed: () => onCompleteChallenge(false),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: const BorderSide(
                        color: Color(0xFFCBD5E1),
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Failed 😅',
                      style: GoogleFonts.comicNeue(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
