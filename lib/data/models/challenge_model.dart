import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum ChallengeType {
  smakprov,
  supersur,
  ataSnore,
  snurraKlubba,
  byggaTorn,
  gissaHand,
  stenSaxPase,
  singlaSlant,
  storstBubbla,
  fangaGodis,
  sanningEllerKonsekvens,
  hogstVinnerTarning,
  narmastVinnerDrop,
  narmastVinnerKast,
  lukttest,
  draSticka,
  santEllerFalskt,
  snurra,
}

class ChallengeModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String instruction;
  final String candyReward;
  final IconData icon;
  final Color accentColor;
  final ChallengeType type;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.instruction,
    required this.candyReward,
    required this.icon,
    required this.accentColor,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, instruction, candyReward, type];

  static List<ChallengeModel> get allChallenges => [
    const ChallengeModel(
      id: 'smakprov',
      title: 'Taste Test',
      subtitle: 'Taste Test x5 - Filled Gum Cubes',
      instruction:
          'Chew on a mystery white candy! Guess whether the filling is strawberry, green apple, or banana. Show your tongue to your rivals – the color reveals the truth!',
      candyReward: '1 Taste Test Cube',
      icon: Icons.cookie_outlined,
      accentColor: kCandyPink,
      type: ChallengeType.smakprov,
    ),
    const ChallengeModel(
      id: 'supersur',
      title: 'Super Sour',
      subtitle: 'Keep a straight face test',
      instruction:
          'Suck on a super sour candy for 30 seconds without making a facial expression. Rivals watch closely! Keep a straight face to win.',
      candyReward: '1 Super Sour Candy',
      icon: Icons.mood_bad_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.supersur,
    ),
    const ChallengeModel(
      id: 'ata_snore',
      title: 'Eat The Candy Lace',
      subtitle: 'Fastest wins with hands behind back',
      instruction:
          'You and an opponent take opposite ends of a candy lace using your mouth only. Hands behind your back! The fastest to eat to the center wins.',
      candyReward: '1 Candy Lace',
      icon: Icons.timeline_rounded,
      accentColor: kCandyRed,
      type: ChallengeType.ataSnore,
    ),
    const ChallengeModel(
      id: 'snurra_klubba',
      title: 'Spin The Lollipop',
      subtitle: 'Lollipop spin battle',
      instruction:
          'Spin the lollipop like a spinning top on the table. Challenge a rival – the lollipop that spins the longest wins the candy!',
      candyReward: '1 Spinning Lollipop',
      icon: Icons.rotate_right_rounded,
      accentColor: kCandyOrange,
      type: ChallengeType.snurraKlubba,
    ),
    const ChallengeModel(
      id: 'bygga_torn',
      title: 'Tower Builder',
      subtitle: 'Stack candy markers',
      instruction:
          'Stack candy pieces on top of each other into a tall tower in 20 seconds. The player with the highest standing tower wins!',
      candyReward: '1 Candy Marker',
      icon: Icons.layers_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.byggaTorn,
    ),
    const ChallengeModel(
      id: 'gissa_hand',
      title: 'Guess The Hand',
      subtitle: 'Hide 1 candy in a fist',
      instruction:
          'Hide a candy in one hand behind your back. Extend both closed fists forward. Your opponent has to guess which hand holds the candy.',
      candyReward: 'The Hidden Candy',
      icon: Icons.front_hand_rounded,
      accentColor: kCandyPurple,
      type: ChallengeType.gissaHand,
    ),
    const ChallengeModel(
      id: 'sten_sax_pase',
      title: 'Rock Paper Scissors',
      subtitle: 'Best of three showdown',
      instruction:
          'A classic battle! Play rock, paper, scissors against any rival. Best 2 out of 3 rounds takes home the candy prize.',
      candyReward: '1 Choice Candy',
      icon: Icons.pan_tool_alt_rounded,
      accentColor: kCandyBlue,
      type: ChallengeType.stenSaxPase,
    ),
    const ChallengeModel(
      id: 'singla_slant',
      title: 'Flip The Candy Coin',
      subtitle: 'Heads or tails',
      instruction:
          'Flip a candy marker in the air and catch it on the back of your hand. Your opponent calls the color/side before it lands.',
      candyReward: '1 Candy Marker',
      icon: Icons.monetization_on_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.singlaSlant,
    ),
    const ChallengeModel(
      id: 'storst_bubbla',
      title: 'Biggest Bubble',
      subtitle: 'Bubble gum competition',
      instruction:
          'Chew and blow the biggest bubble gum you can muster! Rivals decide who blew the most impressive bubble.',
      candyReward: '1 Bubble Gum Pack',
      icon: Icons.bubble_chart_rounded,
      accentColor: kCandyPink,
      type: ChallengeType.storstBubbla,
    ),
    const ChallengeModel(
      id: 'fanga_godis',
      title: 'Catch Candy With Mouth',
      subtitle: 'Precision catch',
      instruction:
          'A rival tosses a soft candy in an arc from 1.5 meters away. Catch the flying candy directly in your mouth!',
      candyReward: 'The Caught Candy',
      icon: Icons.sports_baseball_rounded,
      accentColor: kCandyGreen,
      type: ChallengeType.fangaGodis,
    ),
    const ChallengeModel(
      id: 'sanning_konsekvens',
      title: 'Truth Or Dare',
      subtitle: 'Party classic',
      instruction:
          'Choose between answering a spicy question truthfully from your rival or performing a hilarious dare.',
      candyReward: '1 Bonus Candy',
      icon: Icons.question_answer_rounded,
      accentColor: kCandyPurple,
      type: ChallengeType.sanningEllerKonsekvens,
    ),
    const ChallengeModel(
      id: 'hogst_vinner_tarning',
      title: 'Highest Roll Wins',
      subtitle: 'Dice duel',
      instruction:
          'Roll the candy dice against an opponent! Whoever rolls the highest number wins the die and gets to munch it.',
      candyReward: '1 Candy Die',
      icon: Icons.casino_rounded,
      accentColor: kCandyRed,
      type: ChallengeType.hogstVinnerTarning,
    ),
    const ChallengeModel(
      id: 'drop',
      title: 'Candy Drop (Closest Wins)',
      subtitle: 'Drop from nose height',
      instruction:
          'Hold a candy at nose height above the gameboard target circle and drop it. The player who lands closest to the bullseye wins!',
      candyReward: '1 Target Candy',
      icon: Icons.arrow_downward_rounded,
      accentColor: kCandyBlue,
      type: ChallengeType.narmastVinnerDrop,
    ),
    const ChallengeModel(
      id: 'sant_falskt',
      title: 'True Or False',
      subtitle: 'Fact or fiction',
      instruction:
          'State a wild personal story or surprising trivia fact. Your rival has 10 seconds to decide whether it is true or false.',
      candyReward: '1 Choice Candy',
      icon: Icons.fact_check_rounded,
      accentColor: kCandyGreen,
      type: ChallengeType.santEllerFalskt,
    ),
    const ChallengeModel(
      id: 'lukttest',
      title: 'Blind Smell Test',
      subtitle: 'Sensory test with closed eyes',
      instruction:
          'Close your eyes completely! A rival holds a candy piece under your nose. Guess the exact flavor using only your sense of smell.',
      candyReward: 'The Aroma Candy',
      icon: Icons.air_rounded,
      accentColor: kCandyOrange,
      type: ChallengeType.lukttest,
    ),
    const ChallengeModel(
      id: 'dra_sticka',
      title: 'Draw The Long String',
      subtitle: 'Longest string wins',
      instruction:
          'A player holds hidden laces in a closed hand. Draw one lace simultaneously – whichever player pulls the longest string wins!',
      candyReward: '1 Long Candy Lace',
      icon: Icons.height_rounded,
      accentColor: kCandyPink,
      type: ChallengeType.draSticka,
    ),
  ];
}
