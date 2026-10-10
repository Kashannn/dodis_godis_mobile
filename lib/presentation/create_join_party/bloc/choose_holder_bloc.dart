import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_holder_event.dart';
import 'choose_holder_state.dart';
import 'create_party_state.dart';

class ChooseHolderBloc extends Bloc<ChooseHolderEvent, ChooseHolderState> {
  ChooseHolderBloc({required List<PartyPlayerModel> initialPlayers})
      : super(ChooseHolderState(
          players: initialPlayers,
          activePlayerIndex: 0,
        )) {
    on<SelectActivePlayerEvent>(_onSelectActivePlayer);
    on<ChangeActivePlayerColorEvent>(_onChangeActivePlayerColor);
  }

  void _onSelectActivePlayer(
    SelectActivePlayerEvent event,
    Emitter<ChooseHolderState> emit,
  ) {
    if (event.playerIndex >= 0 && event.playerIndex < state.players.length) {
      emit(state.copyWith(activePlayerIndex: event.playerIndex));
    }
  }

  void _onChangeActivePlayerColor(
    ChangeActivePlayerColorEvent event,
    Emitter<ChooseHolderState> emit,
  ) {
    final updatedPlayers = List<PartyPlayerModel>.from(state.players);
    final current = updatedPlayers[state.activePlayerIndex];
    updatedPlayers[state.activePlayerIndex] = current.copyWith(
      holderColor: event.colorOption.color,
      holderColorName: event.colorOption.name,
    );

    emit(state.copyWith(players: updatedPlayers));
  }
}
