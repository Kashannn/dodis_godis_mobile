import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/yatzy_score_model.dart';
import 'yatzy_event.dart';
import 'yatzy_state.dart';

class YatzyBloc extends Bloc<YatzyEvent, YatzyState> {
  final Random _random = Random();

  YatzyBloc() : super(YatzyState.initial()) {
    on<RollYatzyDiceEvent>(_onRollDice);
    on<ToggleHoldDieEvent>(_onToggleHoldDie);
    on<RecordScoreEvent>(_onRecordScore);
    on<ResetYatzyGameEvent>(_onResetGame);
  }

  Future<void> _onRollDice(
    RollYatzyDiceEvent event,
    Emitter<YatzyState> emit,
  ) async {
    if (state.rollsRemaining <= 0 || state.isRolling) return;

    emit(state.copyWith(isRolling: true));
    await Future.delayed(const Duration(milliseconds: 300));

    final newDice = List<int>.from(state.dice);
    for (int i = 0; i < 5; i++) {
      if (!state.heldDice[i]) {
        newDice[i] = _random.nextInt(6) + 1;
      }
    }

    final newRolls = state.rollsRemaining - 1;
    final message = newRolls > 0
        ? 'Choose dice to save, or roll again ($newRolls rolls left).'
        : 'No rolls remaining! Choose a category in the scorecard below.';

    emit(state.copyWith(
      dice: newDice,
      rollsRemaining: newRolls,
      isRolling: false,
      message: message,
    ));
  }

  void _onToggleHoldDie(
    ToggleHoldDieEvent event,
    Emitter<YatzyState> emit,
  ) {
    if (state.rollsRemaining == 3) return; // Haven't rolled yet this turn
    final newHeld = List<bool>.from(state.heldDice);
    newHeld[event.dieIndex] = !newHeld[event.dieIndex];
    emit(state.copyWith(heldDice: newHeld));
  }

  void _onRecordScore(
    RecordScoreEvent event,
    Emitter<YatzyState> emit,
  ) {
    final player = state.currentPlayer;
    if (player.scores.containsKey(event.categoryId)) return; // Already recorded

    final score = _calculateScore(event.categoryId, state.dice);
    final updatedScores = Map<String, int?>.from(player.scores);
    updatedScores[event.categoryId] = score;

    final updatedPlayers = List<YatzyPlayer>.from(state.players);
    updatedPlayers[state.currentPlayerIndex] = player.copyWith(scores: updatedScores);

    // Switch to next player and reset dice
    final nextPlayerIndex = (state.currentPlayerIndex + 1) % state.players.length;

    emit(state.copyWith(
      players: updatedPlayers,
      currentPlayerIndex: nextPlayerIndex,
      dice: [1, 2, 3, 4, 5],
      heldDice: [false, false, false, false, false],
      rollsRemaining: 3,
      message: 'Score saved ($score pts)! Now it is ${state.players[nextPlayerIndex].name}’s turn.',
    ));
  }

  void _onResetGame(
    ResetYatzyGameEvent event,
    Emitter<YatzyState> emit,
  ) {
    emit(YatzyState.initial());
  }

  int _calculateScore(String categoryId, List<int> dice) {
    final counts = <int, int>{};
    for (var d in dice) {
      counts[d] = (counts[d] ?? 0) + 1;
    }

    switch (categoryId) {
      case 'ettor':
        return (counts[1] ?? 0) * 1;
      case 'tvaor':
        return (counts[2] ?? 0) * 2;
      case 'treor':
        return (counts[3] ?? 0) * 3;
      case 'fyror':
        return (counts[4] ?? 0) * 4;
      case 'femmor':
        return (counts[5] ?? 0) * 5;
      case 'sexor':
        return (counts[6] ?? 0) * 6;
      case 'ett_par':
        for (int i = 6; i >= 1; i--) {
          if ((counts[i] ?? 0) >= 2) return i * 2;
        }
        return 0;
      case 'tva_par':
        final pairs = <int>[];
        for (int i = 6; i >= 1; i--) {
          if ((counts[i] ?? 0) >= 2) pairs.add(i);
        }
        if (pairs.length >= 2) return (pairs[0] * 2) + (pairs[1] * 2);
        return 0;
      case 'tretal':
        for (int i = 6; i >= 1; i--) {
          if ((counts[i] ?? 0) >= 3) return i * 3;
        }
        return 0;
      case 'fyrtal':
        for (int i = 6; i >= 1; i--) {
          if ((counts[i] ?? 0) >= 4) return i * 4;
        }
        return 0;
      case 'liten_stege':
        final sorted = dice.toSet().toList()..sort();
        if (sorted.length == 5 && sorted[0] == 1 && sorted[4] == 5) return 15;
        return 0;
      case 'stor_stege':
        final sorted = dice.toSet().toList()..sort();
        if (sorted.length == 5 && sorted[0] == 2 && sorted[4] == 6) return 20;
        return 0;
      case 'kak':
        bool has3 = false;
        bool has2 = false;
        for (var c in counts.values) {
          if (c == 3) has3 = true;
          if (c == 2) has2 = true;
        }
        return (has3 && has2) ? dice.reduce((a, b) => a + b) : 0;
      case 'chans':
        return dice.reduce((a, b) => a + b);
      case 'yatzy':
        for (var c in counts.values) {
          if (c == 5) return 50;
        }
        return 0;
      default:
        return 0;
    }
  }
}
