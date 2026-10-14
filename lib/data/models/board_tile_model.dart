import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'challenge_model.dart';

enum BoardTileType {
  blankCandy, // Blank circle where a candy marker from the bag is placed
  challenge, // Special marked challenge circle (Utmaning)
  kastaOm, // Re-roll dice circle
  stationHub, // Large colored holder station hub
}

class BoardTileModel extends Equatable {
  final int index;
  final BoardTileType type;
  final String title;
  final String swedishTitle;
  final ChallengeModel? challenge;
  final Color baseColor;
  final bool hasCandy;

  const BoardTileModel({
    required this.index,
    required this.type,
    required this.title,
    required this.swedishTitle,
    this.challenge,
    required this.baseColor,
    this.hasCandy = true,
  });

  BoardTileModel copyWith({
    int? index,
    BoardTileType? type,
    String? title,
    String? swedishTitle,
    ChallengeModel? challenge,
    Color? baseColor,
    bool? hasCandy,
  }) {
    return BoardTileModel(
      index: index ?? this.index,
      type: type ?? this.type,
      title: title ?? this.title,
      swedishTitle: swedishTitle ?? this.swedishTitle,
      challenge: challenge ?? this.challenge,
      baseColor: baseColor ?? this.baseColor,
      hasCandy: hasCandy ?? this.hasCandy,
    );
  }

  @override
  List<Object?> get props => [
        index,
        type,
        title,
        swedishTitle,
        challenge,
        baseColor,
        hasCandy,
      ];

  /// The standard 24-tile gameboard layout directly matching the physical board
  static List<BoardTileModel> defaultBoardTiles() {
    final challenges = ChallengeModel.allChallenges;
    ChallengeModel findChallenge(String id) =>
        challenges.firstWhere((c) => c.id == id, orElse: () => challenges.first);

    return [
      // 0: Top Station Hub (Smakprov - Taste Test)
      BoardTileModel(
        index: 0,
        type: BoardTileType.stationHub,
        title: 'Taste Test',
        swedishTitle: 'Smakprov',
        challenge: findChallenge('smakprov'),
        baseColor: const Color(0xFF42A5F5), // Blue Hub
      ),

      // 1: Blank circle with candy
      const BoardTileModel(
        index: 1,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFF66BB6A), // Green Candy
      ),

      // 2: Challenge (Sant eller Falskt)
      BoardTileModel(
        index: 2,
        type: BoardTileType.challenge,
        title: 'True or False',
        swedishTitle: 'Sant eller Falskt',
        challenge: findChallenge('sant_falskt'),
        baseColor: const Color(0xFF81C784),
      ),

      // 3: Blank circle with candy
      const BoardTileModel(
        index: 3,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFFFFD54F), // Yellow Candy
      ),

      // 4: Kasta Om (Reroll)
      const BoardTileModel(
        index: 4,
        type: BoardTileType.kastaOm,
        title: 'Roll Again',
        swedishTitle: 'Kasta Om',
        baseColor: Color(0xFFFF7043),
      ),

      // 5: Challenge (Bygga Torn)
      BoardTileModel(
        index: 5,
        type: BoardTileType.challenge,
        title: 'Tower Builder',
        swedishTitle: 'Bygga Torn',
        challenge: findChallenge('bygga_torn'),
        baseColor: const Color(0xFFFFCA28),
      ),

      // 6: Right Station Hub (Super Sur)
      BoardTileModel(
        index: 6,
        type: BoardTileType.stationHub,
        title: 'Super Sour',
        swedishTitle: 'Super Sur',
        challenge: findChallenge('supersur'),
        baseColor: const Color(0xFFFFD600), // Yellow Hub
      ),

      // 7: Blank circle with candy
      const BoardTileModel(
        index: 7,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFFEF5350), // Red Candy
      ),

      // 8: Challenge (Luffarschack / Noughts & Crosses)
      BoardTileModel(
        index: 8,
        type: BoardTileType.challenge,
        title: 'Noughts & Crosses',
        swedishTitle: 'Luffarschack',
        challenge: findChallenge('luffarschack'),
        baseColor: const Color(0xFF42A5F5),
      ),

      // 9: Blank circle with candy
      const BoardTileModel(
        index: 9,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFFAB47BC), // Purple Candy
      ),

      // 10: Kasta Om (Reroll)
      const BoardTileModel(
        index: 10,
        type: BoardTileType.kastaOm,
        title: 'Roll Again',
        swedishTitle: 'Kasta Om',
        baseColor: Color(0xFFFF7043),
      ),

      // 11: Challenge (Gissa Hand)
      BoardTileModel(
        index: 11,
        type: BoardTileType.challenge,
        title: 'Guess Hand',
        swedishTitle: 'Gissa Hand',
        challenge: findChallenge('gissa_hand'),
        baseColor: const Color(0xFFBA68C8),
      ),

      // 12: Bottom Station Hub (Äta Snöre)
      BoardTileModel(
        index: 12,
        type: BoardTileType.stationHub,
        title: 'Eat Candy Lace',
        swedishTitle: 'Äta Snöre',
        challenge: findChallenge('ata_snore'),
        baseColor: const Color(0xFFEF5350), // Red Hub
      ),

      // 13: Blank circle with candy
      const BoardTileModel(
        index: 13,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFF29B6F6), // Cyan Candy
      ),

      // 14: Challenge (Singla Slant)
      BoardTileModel(
        index: 14,
        type: BoardTileType.challenge,
        title: 'Coin Flip',
        swedishTitle: 'Singla Slant',
        challenge: findChallenge('singla_slant'),
        baseColor: const Color(0xFFFFA726),
      ),

      // 15: Blank circle with candy
      const BoardTileModel(
        index: 15,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFFFFB300), // Orange Candy
      ),

      // 16: Kasta Om (Reroll)
      const BoardTileModel(
        index: 16,
        type: BoardTileType.kastaOm,
        title: 'Roll Again',
        swedishTitle: 'Kasta Om',
        baseColor: Color(0xFFFF7043),
      ),

      // 17: Challenge (Fånga Godis)
      BoardTileModel(
        index: 17,
        type: BoardTileType.challenge,
        title: 'Catch Candy',
        swedishTitle: 'Fånga Godis',
        challenge: findChallenge('fanga_godis'),
        baseColor: const Color(0xFF66BB6A),
      ),

      // 18: Left Station Hub (Snurra Klubba)
      BoardTileModel(
        index: 18,
        type: BoardTileType.stationHub,
        title: 'Spin Lollipop',
        swedishTitle: 'Snurra Klubba',
        challenge: findChallenge('snurra_klubba'),
        baseColor: const Color(0xFF8E24AA), // Purple Hub
      ),

      // 19: Blank circle with candy
      const BoardTileModel(
        index: 19,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFFEC407A), // Pink Candy
      ),

      // 20: Challenge (Sanning eller Konsekvens)
      BoardTileModel(
        index: 20,
        type: BoardTileType.challenge,
        title: 'Truth or Dare',
        swedishTitle: 'Sanning eller Konsekvens',
        challenge: findChallenge('sanning_konsekvens'),
        baseColor: const Color(0xFFAB47BC),
      ),

      // 21: Blank circle with candy
      const BoardTileModel(
        index: 21,
        type: BoardTileType.blankCandy,
        title: 'Candy Field',
        swedishTitle: 'Godis',
        baseColor: Color(0xFF4CAF50), // Green Candy
      ),

      // 22: Kasta Om (Reroll)
      const BoardTileModel(
        index: 22,
        type: BoardTileType.kastaOm,
        title: 'Roll Again',
        swedishTitle: 'Kasta Om',
        baseColor: Color(0xFFFF7043),
      ),

      // 23: Challenge (Lukt-test)
      BoardTileModel(
        index: 23,
        type: BoardTileType.challenge,
        title: 'Smell Test',
        swedishTitle: 'Lukt-test',
        challenge: findChallenge('lukttest'),
        baseColor: const Color(0xFFFF7043),
      ),
    ];
  }
}
