import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../widgets/party_mode_selector_widget.dart';

abstract class CreatePartyEvent extends Equatable {
  const CreatePartyEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePlayerHolderColorEvent extends CreatePartyEvent {
  final int playerIndex;
  final Color color;
  final String colorName;

  const UpdatePlayerHolderColorEvent({
    required this.playerIndex,
    required this.color,
    required this.colorName,
  });

  @override
  List<Object?> get props => [playerIndex, color, colorName];
}

class UpdatePartyNameEvent extends CreatePartyEvent {
  final String name;

  const UpdatePartyNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdatePlayerCountEvent extends CreatePartyEvent {
  final int count;

  const UpdatePlayerCountEvent(this.count);

  @override
  List<Object?> get props => [count];
}

class UpdatePlayerNameEvent extends CreatePartyEvent {
  final int index;
  final String name;

  const UpdatePlayerNameEvent({
    required this.index,
    required this.name,
  });

  @override
  List<Object?> get props => [index, name];
}

class ClearPlayerNameEvent extends CreatePartyEvent {
  final int index;

  const ClearPlayerNameEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateGameModeEvent extends CreatePartyEvent {
  final GameModeOption mode;

  const UpdateGameModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}
