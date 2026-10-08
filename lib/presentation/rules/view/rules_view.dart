import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../widgets/rules_tile_widget.dart';

class RulesView extends StatefulWidget {
  const RulesView({super.key});

  @override
  State<RulesView> createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> _ruleSections = [
    {
      'title': 'Dodis Godis Game (Front Side)',
      'category': 'Main Game',
      'icon': Icons.track_changes_rounded,
      'color': kCandyRed,
      'rules': [
        'Preparation: Spread candies around the outer ring of the board. Circles without specific candy markings receive candy markers.',
        'Each player picks a candy container (doubles as a shot glass) and places it on the start space.',
        'On your turn: Roll the digital dice in the app and move clockwise. The space you land on dictates your challenge.',
        'Choose whichever rival you wish to challenge.',
        'Complete the challenge to win the candy!',
        'Win condition: The player who collects the final candy piece from the board or bag wins the game!',
      ],
    },
    {
      'title': 'Yatzy (Back Side)',
      'category': 'Dice Game',
      'icon': Icons.casino_rounded,
      'color': kCandyYellow,
      'rules': [
        'Played with 5 candy dice and the digital scorecard in the app.',
        'Each player gets up to 3 rolls per turn with the ability to hold dice between rolls.',
        'Score one category per turn (Ones through Sixes, Pairs, Straights, Full House, Yatzy, etc.).',
        'Scoring 63 or more on the upper section awards a 50-point bonus.',
        'Dodis Godis Victory Rule: The overall winner gets to feast on the delicious candy dice!',
      ],
    },
    {
      'title': 'Backgammon (Back Side)',
      'category': 'Classic Board Game',
      'icon': Icons.grid_view_rounded,
      'color': kBoardWood,
      'rules': [
        'Played on the green back side with 15 red and 15 white candy markers plus 4 dice.',
        'Players move pieces in opposite directions around the board based on dice rolls.',
        'Capturing an exposed blot sends it to the center wooden bar.',
        'Candy rule: Captured pieces can either be eaten immediately, or redeemed by completing a dare!',
      ],
    },
    {
      'title': 'Connect 4 (Back Side)',
      'category': 'Quick Game',
      'icon': Icons.view_comfy_rounded,
      'color': kCandyBlue,
      'rules': [
        'Played on the 7x6 grid on the back of the board with 21 red and 21 white candies.',
        'Players take turns placing one candy on the grid.',
        'The goal is to connect 4 of your candies in an unbroken horizontal, vertical, or diagonal row.',
        'The winner gets to eat their winning 4-in-a-row line!',
      ],
    },
    {
      'title': 'Tic-Tac-Toe (Front Corner)',
      'category': 'Quick Game',
      'icon': Icons.tag_rounded,
      'color': kCandyGreen,
      'rules': [
        'Played on the 3x3 grid in the corner of the front board.',
        'Place candy markers alternately. First to align 3 in a row takes the round.',
      ],
    },
    {
      'title': 'Pre-Party & Shot Shot Shot',
      'category': 'Party',
      'icon': Icons.local_bar_rounded,
      'color': kShotModeColor,
      'rules': [
        'Dodis Godis candy containers are filled with party beverages and used as shot glasses.',
        'Every lost challenge around the board results in a celebratory toast/shot instead of a candy.',
        'The ultimate icebreaker before heading out for the night!',
      ],
    },
    {
      'title': 'Trivia Quiz / TP Color Wedges',
      'category': 'Trivia Quiz',
      'icon': Icons.psychology_rounded,
      'color': kCandyPurple,
      'rules': [
        'Use the color wedges in the center of the board as a category trivia wheel.',
        'Answer general knowledge questions. Correct answers earn colored candy markers.',
        'First player to collect a candy from every color sector wins the trivia crown!',
      ],
    },
    {
      'title': 'Date Cards (Icebreakers & Naughty +18)',
      'category': 'Date',
      'icon': Icons.favorite_rounded,
      'color': kCandyPink,
      'rules': [
        'Pull up the app on your date and draw one card at a time.',
        'No passing allowed without a candy forfeit or consequence!',
        'Guarantees genuine laughs, deep conversations, and zero awkward pauses.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _ruleSections.where((item) {
      final title = item['title'].toString().toLowerCase();
      final cat = item['category'].toString().toLowerCase();
      final q = _searchQuery.toLowerCase();
      return title.contains(q) || cat.contains(q);
    }).toList();

    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kRulesTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
      ),
      body: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: kSearchRulesHint,
                  hintStyle: kBodyMedium,
                  prefixIcon: const Icon(Icons.search_rounded, color: kSecondaryTextColor),
                  filled: true,
                  fillColor: kWhite,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: kBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: kBorderColor),
                  ),
                ),
              ),
            ),

            // Rules List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                itemCount: filtered.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  return RulesTileWidget(section: filtered[index]);
                },
              ),
            ),
          ],
        ),
    );
  }
}
