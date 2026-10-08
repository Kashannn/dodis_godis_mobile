import 'package:equatable/equatable.dart';

import '../../../data/models/yatzy_score_model.dart';

class YatzyState extends Equatable {
  final List<int> dice;
  final List<bool> heldDice;
  final int rollsRemaining;
  final bool isRolling;
  final List<YatzyPlayer> players;
  final int currentPlayerIndex;
  final String message;

  const YatzyState({
    required this.dice,
    required this.heldDice,
    required this.rollsRemaining,
    required this.isRolling,
    required this.players,
    required this.currentPlayerIndex,
    required this.message,
  });

  factory YatzyState.initial() {
    return YatzyState(
      dice: const [1, 2, 3, 4, 5],
      heldDice: const [false, false, false, false, false],
      rollsRemaining: 3,
      isRolling: false,
      players: [
        YatzyPlayer.initial('Player A'),
        YatzyPlayer.initial('Player B'),
      ],
      currentPlayerIndex: 0,
      message: 'Roll the dice! You have 3 rolls remaining.',
    );
  }

  YatzyPlayer get currentPlayer => players[currentPlayerIndex];

  YatzyState copyWith({
    List<int>? dice,
    List<bool>? heldDice,
    int? rollsRemaining,
    bool? isRolling,
    List<YatzyPlayer>? players,
    int? currentPlayerIndex,
    String? message,
  }) {
    return YatzyState(
      dice: dice ?? this.dice,
      heldDice: heldDice ?? this.heldDice,
      rollsRemaining: rollsRemaining ?? this.rollsRemaining,
      isRolling: isRolling ?? this.isRolling,
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    dice,
    heldDice,
    rollsRemaining,
    isRolling,
    players,
    currentPlayerIndex,
    message,
  ];
}
