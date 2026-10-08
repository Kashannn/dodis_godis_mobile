import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/challenge_model.dart';
import 'dodis_game_event.dart';
import 'dodis_game_state.dart';

class DodisGameBloc extends Bloc<DodisGameEvent, DodisGameState> {
  final Random _random = Random();

  DodisGameBloc() : super(DodisGameState.initial()) {
    on<RollDiceEvent>(_onRollDice);
    on<SelectOpponentEvent>(_onSelectOpponent);
    on<CompleteChallengeEvent>(_onCompleteChallenge);
    on<NextTurnEvent>(_onNextTurn);
    on<AddPlayerEvent>(_onAddPlayer);
    on<ResetGameEvent>(_onResetGame);
  }

  Future<void> _onRollDice(
    RollDiceEvent event,
    Emitter<DodisGameState> emit,
  ) async {
    if (state.isRollingDice) return;

    emit(state.copyWith(
      isRollingDice: true,
      status: DodisGameStatus.rolling,
      message: 'Rolling dice...',
    ));

    await Future.delayed(const Duration(milliseconds: 600));

    final roll = _random.nextInt(6) + 1;
    final player = state.currentPlayer;
    final newTile = (player.currentTile + roll) % 24;

    // Pick challenge for the tile
    final challenges = ChallengeModel.allChallenges;
    final challenge = challenges[newTile % challenges.length];

    // Pick default opponent (first non-current player)
    final opponents = state.players.where((p) => p.id != player.id).toList();
    final defaultOpponent = opponents.isNotEmpty ? opponents.first.name : null;

    final updatedPlayers = List<GamePlayer>.from(state.players);
    updatedPlayers[state.currentPlayerIndex] = player.copyWith(
      currentTile: newTile,
    );

    emit(state.copyWith(
      players: updatedPlayers,
      lastDiceRoll: roll,
      isRollingDice: false,
      currentChallenge: challenge,
      selectedOpponent: defaultOpponent,
      status: DodisGameStatus.challengeActive,
      message: '${player.name} rolled a $roll! Challenge: ${challenge.title}',
    ));
  }

  void _onSelectOpponent(
    SelectOpponentEvent event,
    Emitter<DodisGameState> emit,
  ) {
    emit(state.copyWith(selectedOpponent: event.opponentName));
  }

  void _onCompleteChallenge(
    CompleteChallengeEvent event,
    Emitter<DodisGameState> emit,
  ) {
    final player = state.currentPlayer;
    final updatedPlayers = List<GamePlayer>.from(state.players);

    final newCandies = event.didWin ? player.candyCount + 1 : player.candyCount;
    final remainingBag = event.didWin
        ? max(0, state.totalCandiesInBag - 1)
        : state.totalCandiesInBag;

    updatedPlayers[state.currentPlayerIndex] = player.copyWith(
      candyCount: newCandies,
    );

    final isGameOver = remainingBag == 0;

    emit(state.copyWith(
      players: updatedPlayers,
      totalCandiesInBag: remainingBag,
      status: isGameOver
          ? DodisGameStatus.gameOver
          : DodisGameStatus.challengeResolved,
      message: event.didWin
          ? '🎉 Great job! ${player.name} won 1 candy!'
          : '😅 Oops! Better luck next round.',
    ));
  }

  void _onNextTurn(NextTurnEvent event, Emitter<DodisGameState> emit) {
    final nextIndex = (state.currentPlayerIndex + 1) % state.players.length;
    emit(state.copyWith(
      currentPlayerIndex: nextIndex,
      status: DodisGameStatus.waitingForRoll,
      currentChallenge: null,
      message: 'Now it is ${state.players[nextIndex].name}’s turn to roll!',
    ));
  }

  void _onAddPlayer(AddPlayerEvent event, Emitter<DodisGameState> emit) {
    if (state.players.length >= 6) return;
    final newId = '${state.players.length + 1}';
    final newPlayer = GamePlayer(
      id: newId,
      name: event.playerName.isEmpty ? 'Player $newId' : event.playerName,
      candyCount: 0,
      currentTile: 0,
      avatarIndex: state.players.length % 6,
    );

    emit(state.copyWith(players: [...state.players, newPlayer]));
  }

  void _onResetGame(ResetGameEvent event, Emitter<DodisGameState> emit) {
    emit(DodisGameState.initial());
  }
}
