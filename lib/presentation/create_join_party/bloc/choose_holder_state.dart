import 'package:equatable/equatable.dart';

import 'create_party_state.dart';

class ChooseHolderState extends Equatable {
  final List<PartyPlayerModel> players;
  final int activePlayerIndex;

  const ChooseHolderState({
    required this.players,
    required this.activePlayerIndex,
  });

  PartyPlayerModel get activePlayer =>
      players.isNotEmpty && activePlayerIndex < players.length
          ? players[activePlayerIndex]
          : players.first;

  ChooseHolderState copyWith({
    List<PartyPlayerModel>? players,
    int? activePlayerIndex,
  }) {
    return ChooseHolderState(
      players: players ?? this.players,
      activePlayerIndex: activePlayerIndex ?? this.activePlayerIndex,
    );
  }

  @override
  List<Object?> get props => [players, activePlayerIndex];
}
