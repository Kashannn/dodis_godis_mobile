import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_images.dart';
import 'create_party_event.dart';
import 'create_party_state.dart';

class CreatePartyBloc extends Bloc<CreatePartyEvent, CreatePartyState> {
  CreatePartyBloc() : super(CreatePartyState.initial()) {
    on<UpdatePartyNameEvent>(_onUpdatePartyName);
    on<UpdatePlayerCountEvent>(_onUpdatePlayerCount);
    on<UpdatePlayerNameEvent>(_onUpdatePlayerName);
    on<ClearPlayerNameEvent>(_onClearPlayerName);
    on<UpdateGameModeEvent>(_onUpdateGameMode);
    on<UpdatePlayerHolderColorEvent>(_onUpdatePlayerHolderColor);
  }

  void _onUpdatePlayerHolderColor(
    UpdatePlayerHolderColorEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    if (event.playerIndex < 0 || event.playerIndex >= state.players.length) {
      return;
    }
    final updatedPlayers = List<PartyPlayerModel>.from(state.players);
    updatedPlayers[event.playerIndex] = updatedPlayers[event.playerIndex].copyWith(
      holderColor: event.color,
      holderColorName: event.colorName,
    );
    emit(state.copyWith(players: updatedPlayers));
  }

  void _onUpdatePartyName(
    UpdatePartyNameEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    emit(state.copyWith(partyName: event.name));
  }

  void _onUpdatePlayerCount(
    UpdatePlayerCountEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    final newCount = event.count.clamp(2, 6);
    final currentPlayers = List<PartyPlayerModel>.from(state.players);

    if (newCount > currentPlayers.length) {
      // Add players with their corresponding avatar, default name and holder color
      for (int i = currentPlayers.length; i < newCount; i++) {
        final defaultColor = CreatePartyState.defaultColors[i % CreatePartyState.defaultColors.length];
        currentPlayers.add(
          PartyPlayerModel(
            id: i + 1,
            name: i < CreatePartyState.defaultNames.length
                ? CreatePartyState.defaultNames[i]
                : 'Player ${i + 1}',
            avatarPath: kPlayerAvatarList[i % kPlayerAvatarList.length],
            isHost: i == 0,
            holderColor: defaultColor.color,
            holderColorName: defaultColor.name,
          ),
        );
      }
    } else if (newCount < currentPlayers.length) {
      // Trim players to new count while keeping existing names
      currentPlayers.removeRange(newCount, currentPlayers.length);
    }

    emit(state.copyWith(
      playerCount: newCount,
      players: currentPlayers,
    ));
  }

  void _onUpdatePlayerName(
    UpdatePlayerNameEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    if (event.index < 0 || event.index >= state.players.length) return;

    final updatedPlayers = List<PartyPlayerModel>.from(state.players);
    updatedPlayers[event.index] = updatedPlayers[event.index].copyWith(
      name: event.name,
    );

    emit(state.copyWith(players: updatedPlayers));
  }

  void _onClearPlayerName(
    ClearPlayerNameEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    if (event.index < 0 || event.index >= state.players.length) return;

    final updatedPlayers = List<PartyPlayerModel>.from(state.players);
    updatedPlayers[event.index] = updatedPlayers[event.index].copyWith(
      name: '',
    );

    emit(state.copyWith(players: updatedPlayers));
  }

  void _onUpdateGameMode(
    UpdateGameModeEvent event,
    Emitter<CreatePartyState> emit,
  ) {
    emit(state.copyWith(mode: event.mode));
  }
}
