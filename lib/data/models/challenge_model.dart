import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';

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

  String get imageAsset {
    switch (id) {
      case 'supersur':
        return kChallengeSuperSourImage;
      case 'sant_falskt':
        return kChallengeTrueFalseImage;
      case 'singla_slant':
        return kChallengeCoinFlipImage;
      case 'gissa_hand':
        return kChallengeGuessHandImage;
      case 'fanga_godis':
        return kChallengeCatchMouthImage;
      case 'ata_snore':
        return kChallengePullStringImage;
      case 'snurra_klubba':
        return kChallengeSpinningTopImage;
      case 'snurra_markor':
        return kChallengeCoinFlipImage;
      case 'bygga_torn':
        return kChallengeByggaTornImage;
      case 'sten_sax_pase':
        return kChallengeStenSaxPaseImage;
      case 'drop':
      case 'narmast_vinner_drop':
        return kChallengeDropImage;
      case 'kast':
      case 'narmast_vinner_kast':
        return kChallengeClosestTossImage;
      case 'storst_bubbla':
        return kChallengeSuperSourImage;
      default:
        return kChallengeTrueFalseImage;
    }
  }

  @override
  List<Object?> get props => [id, title, subtitle, instruction, candyReward, type];

  static List<ChallengeModel> get allChallenges => [
    const ChallengeModel(
      id: 'smakprov',
      title: 'Taste Test',
      subtitle: 'Smaktest (Filled Gum Cubes)',
      instruction:
          'Chew one mystery gum cube without looking. Guess the flavor (Strawberry, Apple, or Banana)! Open your mouth – the color of your tongue proves if you are right!',
      candyReward: '1 Taste Test Cube',
      icon: Icons.cookie_outlined,
      accentColor: kCandyPink,
      type: ChallengeType.smakprov,
    ),
    const ChallengeModel(
      id: 'supersur',
      title: 'Super Sour',
      subtitle: 'Hålla minen (Keep a straight face)',
      instruction:
          'Put a super sour candy in your mouth for 30 seconds. Try to keep a completely straight face – no making funny expressions while rivals watch!',
      candyReward: '1 Super Sour Candy',
      icon: Icons.mood_bad_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.supersur,
    ),
    const ChallengeModel(
      id: 'ata_snore',
      title: 'Eat The Candy Lace',
      subtitle: 'Äta snöre (Fastest without hands)',
      instruction:
          'You and a rival take opposite ends of a candy lace using your mouth only – no hands! The fastest player to eat to the center wins.',
      candyReward: '1 Candy Lace',
      icon: Icons.timeline_rounded,
      accentColor: kCandyRed,
      type: ChallengeType.ataSnore,
    ),
    const ChallengeModel(
      id: 'dra_sticka',
      title: 'Pick Straw (Longest String Wins)',
      subtitle: 'Dra sticka (Candy laces)',
      instruction:
          'A rival holds two candy laces of different lengths hidden in a closed fist. Pick and pull one – the longest string wins!',
      candyReward: '1 Long Candy Lace',
      icon: Icons.height_rounded,
      accentColor: kCandyPink,
      type: ChallengeType.draSticka,
    ),
    const ChallengeModel(
      id: 'snurra_klubba',
      title: 'Spin The Lollipop',
      subtitle: 'Snurra klubba (Spinning top)',
      instruction:
          'There is a lollipop shaped like a spinning top! Both players spin their lollipop on the table – the one that spins the longest wins the candy.',
      candyReward: '1 Spinning Lollipop',
      icon: Icons.rotate_right_rounded,
      accentColor: kCandyOrange,
      type: ChallengeType.snurraKlubba,
    ),
    const ChallengeModel(
      id: 'snurra_markor',
      title: 'Spin A Chip Candy',
      subtitle: 'Snurra godismarkör (Flick & spin)',
      instruction:
          'Flick a chip candy on the table so it spins like a coin! The player whose chip spins the longest wins.',
      candyReward: '1 Chip Candy',
      icon: Icons.refresh_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.snurra,
    ),
    const ChallengeModel(
      id: 'bygga_torn',
      title: 'Tower Builder',
      subtitle: 'Bygga torn (Quickest chip tower)',
      instruction:
          'Stack the chip candies on top of each other into a tall tower as fast as possible. The player who builds the tallest tower quickest wins!',
      candyReward: '1 Candy Marker',
      icon: Icons.layers_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.byggaTorn,
    ),
    const ChallengeModel(
      id: 'gissa_hand',
      title: 'Guess The Hand',
      subtitle: 'Gissa hand (Hide candy in fist)',
      instruction:
          'Hide a candy in one hand behind your back. Extend both closed fists forward. Your opponent has to guess which hand holds the candy!',
      candyReward: 'The Hidden Candy',
      icon: Icons.front_hand_rounded,
      accentColor: kCandyPurple,
      type: ChallengeType.gissaHand,
    ),
    const ChallengeModel(
      id: 'sten_sax_pase',
      title: 'Rock Paper Scissors',
      subtitle: 'Sten sax påse (Best of three)',
      instruction:
          'Play Rock, Paper, Scissors against your rival! Best 2 out of 3 rounds wins the candy.',
      candyReward: '1 Choice Candy',
      icon: Icons.pan_tool_alt_rounded,
      accentColor: kCandyBlue,
      type: ChallengeType.stenSaxPase,
    ),
    const ChallengeModel(
      id: 'singla_slant',
      title: 'Flip The Candy Coin',
      subtitle: 'Singla slant (Tails or heads)',
      instruction:
          'Tails or heads! Flip a chip candy in the air and catch it. The opponent calls the side/color before it lands.',
      candyReward: '1 Candy Marker',
      icon: Icons.monetization_on_rounded,
      accentColor: kCandyYellow,
      type: ChallengeType.singlaSlant,
    ),
    const ChallengeModel(
      id: 'drop',
      title: 'Candy Drop (Closest Wins)',
      subtitle: 'Närmast vinner (Drop from height)',
      instruction:
          'Pick a spot on the board, hold a candy at nose height and drop it. Closest to the target circle wins and gets the candy!',
      candyReward: '1 Target Candy',
      icon: Icons.arrow_downward_rounded,
      accentColor: kCandyBlue,
      type: ChallengeType.narmastVinnerDrop,
    ),
    const ChallengeModel(
      id: 'narmast_vinner_kast',
      title: 'Candy Toss (Closest Wins)',
      subtitle: 'Kasta godis (Throw closest)',
      instruction:
          'Pick a mark on the board or floor and toss a chip candy towards it. Closest to the mark wins and takes the candy!',
      candyReward: '1 Toss Candy',
      icon: Icons.track_changes_rounded,
      accentColor: kCandyGreen,
      type: ChallengeType.narmastVinnerKast,
    ),
    const ChallengeModel(
      id: 'fanga_godis',
      title: 'Catch Candy With Mouth',
      subtitle: 'Fånga godis (Catch in mouth)',
      instruction:
          'A rival tosses a soft candy in an arc from 1.5 meters away. Catch the flying candy directly in your mouth!',
      candyReward: 'The Caught Candy',
      icon: Icons.sports_baseball_rounded,
      accentColor: kCandyGreen,
      type: ChallengeType.fangaGodis,
    ),
    const ChallengeModel(
      id: 'hogst_vinner_tarning',
      title: 'Highest Roll Wins',
      subtitle: 'Högst vinner tärning (Dice duel)',
      instruction:
          'Throw the candy dice against an opponent! Whoever rolls the highest number wins the die and gets to munch it.',
      candyReward: '1 Candy Die',
      icon: Icons.casino_rounded,
      accentColor: kCandyRed,
      type: ChallengeType.hogstVinnerTarning,
    ),
    const ChallengeModel(
      id: 'storst_bubbla',
      title: 'Biggest Bubble',
      subtitle: 'Störst bubbla (Bubblegum contest)',
      instruction:
          'Chew a bubblegum cube and blow the biggest bubble you can! Contestants decide who blew the most impressive bubble.',
      candyReward: '1 Bubble Gum Pack',
      icon: Icons.bubble_chart_rounded,
      accentColor: kCandyPink,
      type: ChallengeType.storstBubbla,
    ),
    const ChallengeModel(
      id: 'sant_falskt',
      title: 'True Or False',
      subtitle: 'Sant eller falskt (Fact or fiction)',
      instruction:
          'State a wild personal story or surprising trivia fact. Your rival has 10 seconds to decide whether it is true or false.',
      candyReward: '1 Choice Candy',
      icon: Icons.fact_check_rounded,
      accentColor: kCandyGreen,
      type: ChallengeType.santEllerFalskt,
    ),
    const ChallengeModel(
      id: 'lukttest',
      title: 'Flavor Breath Test',
      subtitle: 'Lukt-test (Blow & determine taste)',
      instruction:
          'Chew a flavored candy and gently blow your breath towards your contestant. They must determine the taste! Tongue color decides if they are right.',
      candyReward: 'The Aroma Candy',
      icon: Icons.air_rounded,
      accentColor: kCandyOrange,
      type: ChallengeType.lukttest,
    ),
    const ChallengeModel(
      id: 'sanning_konsekvens',
      title: 'Truth Or Dare',
      subtitle: 'Sanning eller konsekvens (Party classic)',
      instruction:
          'Party classic! Choose between answering a spicy question truthfully from your rival or performing a hilarious dare.',
      candyReward: '1 Bonus Candy',
      icon: Icons.question_answer_rounded,
      accentColor: kCandyPurple,
      type: ChallengeType.sanningEllerKonsekvens,
    ),
  ];
}
