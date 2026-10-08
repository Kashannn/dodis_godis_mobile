import 'package:equatable/equatable.dart';

import '../../../data/models/challenge_model.dart';

class GamePlayer extends Equatable {
  final String id;
  final String name;
  final int candyCount;
  final int currentTile;
  final int avatarIndex;

  const GamePlayer({
    required this.id,
    required this.name,
    required this.candyCount,
    required this.currentTile,
    required this.avatarIndex,
  });

  GamePlayer copyWith({
    String? name,
    int? candyCount,
    int? currentTile,
    int? avatarIndex,
  }) {
    return GamePlayer(
      id: id,
      name: name ?? this.name,
      candyCount: candyCount ?? this.candyCount,
      currentTile: currentTile ?? this.currentTile,
      avatarIndex: avatarIndex ?? this.avatarIndex,
    );
  }

  @override
  List<Object?> get props => [id, name, candyCount, currentTile, avatarIndex];
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
    return const DodisGameState(
      players: [
        GamePlayer(id: '1', name: 'Player 1', candyCount: 0, currentTile: 0, avatarIndex: 0),
        GamePlayer(id: '2', name: 'Player 2', candyCount: 0, currentTile: 0, avatarIndex: 1),
        GamePlayer(id: '3', name: 'Player 3', candyCount: 0, currentTile: 0, avatarIndex: 2),
      ],
      currentPlayerIndex: 0,
      lastDiceRoll: 1,
      isRollingDice: false,
      currentChallenge: null,
      selectedOpponent: null,
      status: DodisGameStatus.waitingForRoll,
      message: 'Roll the dice to make your first move!',
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
