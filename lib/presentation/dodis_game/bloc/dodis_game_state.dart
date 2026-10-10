import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../data/models/challenge_model.dart';

class GamePlayer extends Equatable {
  final String id;
  final String name;
  final int candyCount;
  final int currentTile;
  final int avatarIndex;
  final String? avatarPath;
  final Color? holderColor;
  final String? holderColorName;

  const GamePlayer({
    required this.id,
    required this.name,
    required this.candyCount,
    required this.currentTile,
    required this.avatarIndex,
    this.avatarPath,
    this.holderColor,
    this.holderColorName,
  });

  GamePlayer copyWith({
    String? name,
    int? candyCount,
    int? currentTile,
    int? avatarIndex,
    String? avatarPath,
    Color? holderColor,
    String? holderColorName,
  }) {
    return GamePlayer(
      id: id,
      name: name ?? this.name,
      candyCount: candyCount ?? this.candyCount,
      currentTile: currentTile ?? this.currentTile,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      avatarPath: avatarPath ?? this.avatarPath,
      holderColor: holderColor ?? this.holderColor,
      holderColorName: holderColorName ?? this.holderColorName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        candyCount,
        currentTile,
        avatarIndex,
        avatarPath,
        holderColor,
        holderColorName,
      ];
}

enum DodisGameStatus {
  waitingForRoll,
  rolling,
  challengeActive,
  challengeResolved,
  gameOver,
}

class DodisGameState extends Equatable {
  final List<GamePlayer> players;
  final int currentPlayerIndex;
  final int lastDiceRoll;
  final bool isRollingDice;
  final ChallengeModel? currentChallenge;
  final String? selectedOpponent;
  final DodisGameStatus status;
  final String message;
  final int totalCandiesInBag;

  const DodisGameState({
    required this.players,
    required this.currentPlayerIndex,
    required this.lastDiceRoll,
    required this.isRollingDice,
    required this.currentChallenge,
    required this.selectedOpponent,
    required this.status,
    required this.message,
    required this.totalCandiesInBag,
  });

  factory DodisGameState.initial() {
    return DodisGameState(
      players: [
        GamePlayer(
          id: '1',
          name: 'You',
          candyCount: 3,
          currentTile: 0,
          avatarIndex: 0,
          avatarPath: kPlayerAvatarList[0],
          holderColor: kHolderBlue,
          holderColorName: 'Blue',
        ),
        GamePlayer(
          id: '2',
          name: 'Sara',
          candyCount: 2,
          currentTile: 6,
          avatarIndex: 1,
          avatarPath: kPlayerAvatarList[1],
          holderColor: kHolderOrange,
          holderColorName: 'Orange',
        ),
        GamePlayer(
          id: '3',
          name: 'Omar',
          candyCount: 1,
          currentTile: 12,
          avatarIndex: 2,
          avatarPath: kPlayerAvatarList[2],
          holderColor: kHolderPurple,
          holderColorName: 'Purple',
        ),
        GamePlayer(
          id: '4',
          name: 'Noah',
          candyCount: 0,
          currentTile: 18,
          avatarIndex: 3,
          avatarPath: kPlayerAvatarList[3],
          holderColor: kHolderGreen,
          holderColorName: 'Green',
        ),
      ],
      currentPlayerIndex: 0,
      lastDiceRoll: 1,
      isRollingDice: false,
      currentChallenge: null,
      selectedOpponent: null,
      status: DodisGameStatus.waitingForRoll,
      message: 'Tap the dice to make your move!',
      totalCandiesInBag: 30,
    );
  }

  GamePlayer get currentPlayer => players[currentPlayerIndex];

  DodisGameState copyWith({
    List<GamePlayer>? players,
    int? currentPlayerIndex,
    int? lastDiceRoll,
    bool? isRollingDice,
    ChallengeModel? currentChallenge,
    String? selectedOpponent,
    DodisGameStatus? status,
    String? message,
    int? totalCandiesInBag,
  }) {
    return DodisGameState(
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      lastDiceRoll: lastDiceRoll ?? this.lastDiceRoll,
      isRollingDice: isRollingDice ?? this.isRollingDice,
      currentChallenge: currentChallenge ?? this.currentChallenge,
      selectedOpponent: selectedOpponent ?? this.selectedOpponent,
      status: status ?? this.status,
      message: message ?? this.message,
      totalCandiesInBag: totalCandiesInBag ?? this.totalCandiesInBag,
    );
  }

  @override
  List<Object?> get props => [
    players,
    currentPlayerIndex,
    lastDiceRoll,
    isRollingDice,
    currentChallenge,
    selectedOpponent,
    status,
    message,
    totalCandiesInBag,
  ];
}
