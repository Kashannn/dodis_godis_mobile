import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class GameItemModel extends Equatable {
  final String id;
  final String title;
  final String category;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String route;
  final bool hasDigitalCompanion;
  final String badgeText;

  const GameItemModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    this.hasDigitalCompanion = true,
    this.badgeText = '',
  });

  @override
  List<Object?> get props => [id, title, category, subtitle, description, route];
}

class GameCategoryModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final List<GameItemModel> games;

  const GameCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.games,
  });

  @override
  List<Object?> get props => [id, title, description, games];

  static List<GameCategoryModel> get sampleCategories => [
    const GameCategoryModel(
      id: 'forfest',
      title: 'Pre-Party',
      description: 'Warm up with party games and shot or candy challenges',
      icon: Icons.celebration_rounded,
      accentColor: kCandyPink,
      games: [
        GameItemModel(
          id: 'sing_star',
          title: 'Sing Star',
          category: 'Pre-Party',
          subtitle: 'Singing battle with candy & shot penalties',
          description:
              'The app prompts hit songs. Sing along! If you miss the lyric, your opponent gets a candy – or you take a shot!',
          icon: Icons.mic_external_on_rounded,
          color: kCandyYellow,
          route: '/rules',
          badgeText: 'Party Hit',
        ),
        GameItemModel(
          id: 'shot_shot_shot',
          title: 'Shot Shot Shot',
          category: 'Pre-Party',
          subtitle: 'Candy containers used as shot glasses',
          description:
              'Dodis Godis candy containers double as shot glasses! The board turns into an electric party battleground.',
          icon: Icons.local_bar_rounded,
          color: kCandyRed,
          route: '/rules',
          badgeText: '+18 / Party',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'fragesport',
      title: 'Trivia Quiz',
      description: 'Test your knowledge with candy stakes in the pot',
      icon: Icons.psychology_rounded,
      accentColor: kCandyBlue,
      games: [
        GameItemModel(
          id: 'tp_trivia',
          title: 'TP Trivia',
          category: 'Trivia Quiz',
          subtitle: 'Trivial Pursuit x Dodis Godis',
          description:
              'The circular gameboard color wedges represent trivia categories. Answer questions correctly to win colored candy tokens.',
          icon: Icons.pie_chart_rounded,
          color: kCandyPurple,
          route: '/rules',
          badgeText: 'Classic',
        ),
        GameItemModel(
          id: 'alla_mot_alla',
          title: 'All vs All',
          category: 'Trivia Quiz',
          subtitle: 'Fast-paced general knowledge',
          description:
              'The fastest answer takes the candy! All players challenge each other simultaneously in rapid-fire trivia.',
          icon: Icons.groups_rounded,
          color: kCandyGreen,
          route: '/rules',
          badgeText: 'Quick Quiz',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'bradspel',
      title: 'Board Games',
      description: 'Classic board games played on the back of the multifunctional board',
      icon: Icons.dashboard_rounded,
      accentColor: kBoardWood,
      games: [
        GameItemModel(
          id: 'backgammon',
          title: 'Backgammon',
          category: 'Board Games',
          subtitle: 'Played with candy markers & dice',
          description:
              'The back side green field with red and blue triangles. 15 candy pieces per color and 4 dice. Hit opponent pieces and eat them up!',
          icon: Icons.grid_view_rounded,
          color: kBoardWood,
          route: '/rules',
          badgeText: 'Board Back',
        ),
        GameItemModel(
          id: 'dam',
          title: 'Checkers',
          category: 'Board Games',
          subtitle: 'Jump over and eat your opponent',
          description:
              'Classic checkers where you literally eat your opponent’s candy pieces when you jump over them.',
          icon: Icons.border_all_rounded,
          color: kCandyOrange,
          route: '/rules',
          badgeText: 'Candy Stakes',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'tarning',
      title: 'Dice',
      description: 'Digital scorecard and dice roller for candy Yatzy',
      icon: Icons.casino_rounded,
      accentColor: kCandyRed,
      games: [
        GameItemModel(
          id: 'yatzy',
          title: 'Yatzy',
          category: 'Dice',
          subtitle: 'Winner eats the delicious candy dice!',
          description:
              'Complete digital Yatzy scorecard! Roll the 5 candy dice, hold values, and chase the 50-point Yatzy bonus.',
          icon: Icons.casino_rounded,
          color: kCandyRed,
          route: '/yatzy',
          badgeText: 'Interactive',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'snabbspel',
      title: 'Quick Games',
      description: 'Fast casual games for trains, flights, or cozy cafes',
      icon: Icons.bolt_rounded,
      accentColor: kCandyYellow,
      games: [
        GameItemModel(
          id: 'fyra_i_rad',
          title: 'Connect 4',
          category: 'Quick Games',
          subtitle: 'Played on the 7x6 grid',
          description:
              'Use the 21 red and 21 white candy tokens on the grid. Connect 4 candies in a row horizontally, vertically, or diagonally.',
          icon: Icons.view_comfy_rounded,
          color: kCandyYellow,
          route: '/rules',
          badgeText: '21x Markers',
        ),
        GameItemModel(
          id: 'luffarschack',
          title: 'Tic-Tac-Toe',
          category: 'Quick Games',
          subtitle: 'Classic 3x3 corner grid',
          description:
              'The 3x3 grid on the front corner. Place candies alternately. The first to make 3 in a row wins the round.',
          icon: Icons.tag_rounded,
          color: kCandyGreen,
          route: '/rules',
          badgeText: 'Table Mat',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'musik',
      title: 'Music',
      description: 'Sing, guess, and compete in hit lyrics',
      icon: Icons.music_note_rounded,
      accentColor: kCandyPurple,
      games: [
        GameItemModel(
          id: 'resten_av_texten',
          title: 'Finish The Lyric',
          category: 'Music',
          subtitle: 'Complete the missing song line',
          description:
              'The music cuts off mid-chorus – can you sing or recite the rest of the lyric? Correct answers get showered in candy!',
          icon: Icons.queue_music_rounded,
          color: kCandyPurple,
          route: '/rules',
          badgeText: 'Music Game',
        ),
        GameItemModel(
          id: 'whos_song',
          title: "Who's Song",
          category: 'Music',
          subtitle: 'Guess artist & release year',
          description:
              'Hear a short audio snippet and name the artist first. The fastest shout wins the candy pot!',
          icon: Icons.graphic_eq_rounded,
          color: kCandyBlue,
          route: '/rules',
          badgeText: 'Party Quiz',
        ),
      ],
    ),
    const GameCategoryModel(
      id: 'dejt',
      title: 'Date',
      description: 'Break the ice on your date – zero awkward silences!',
      icon: Icons.favorite_rounded,
      accentColor: kCandyPink,
      games: [
        GameItemModel(
          id: 'dejtkort',
          title: 'Date Cards (Icebreakers)',
          category: 'Date',
          subtitle: 'Never an awkward silence',
          description:
              'Entertaining, charming, and personal prompts that spark natural laughter, stories, and warm vibes.',
          icon: Icons.chat_bubble_outline_rounded,
          color: kCandyPink,
          route: '/date-cards',
          badgeText: 'Date Favorite',
        ),
        GameItemModel(
          id: 'naughty_18',
          title: 'Naughty +18',
          category: 'Date',
          subtitle: 'Intimate & daring questions',
          description:
              'When the mood heats up! Flirty, intimate, and thrilling prompts for couples and dates who dare to explore.',
          icon: Icons.local_fire_department_rounded,
          color: kShotModeColor,
          route: '/date-cards',
          badgeText: '+18 Adult',
        ),
      ],
    ),
  ];
}
