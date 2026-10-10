import 'package:equatable/equatable.dart';

import 'dodis_game_state.dart';

abstract class DodisGameEvent extends Equatable {
  const DodisGameEvent();

  @override
  List<Object?> get props => [];
}

class RollDiceEvent extends DodisGameEvent {
  const RollDiceEvent();
}

class NextTurnEvent extends DodisGameEvent {
  const NextTurnEvent();
}

class SelectOpponentEvent extends DodisGameEvent {
  final String opponentName;
  const SelectOpponentEvent(this.opponentName);

  @override
  List<Object?> get props => [opponentName];
}

class CompleteChallengeEvent extends DodisGameEvent {
  final bool didWin;
  const CompleteChallengeEvent({required this.didWin});

  @override
  List<Object?> get props => [didWin];
}

class AddPlayerEvent extends DodisGameEvent {
  final String playerName;
  const AddPlayerEvent(this.playerName);

  @override
  List<Object?> get props => [playerName];
}

class ResetGameEvent extends DodisGameEvent {
  const ResetGameEvent();
}

class SetPartyPlayersEvent extends DodisGameEvent {
  final List<GamePlayer> players;
  const SetPartyPlayersEvent(this.players);

  @override
  List<Object?> get props => [players];
}

