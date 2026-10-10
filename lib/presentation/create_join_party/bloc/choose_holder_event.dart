import 'package:equatable/equatable.dart';

import 'create_party_state.dart';

abstract class ChooseHolderEvent extends Equatable {
  const ChooseHolderEvent();

  @override
  List<Object?> get props => [];
}

class SelectActivePlayerEvent extends ChooseHolderEvent {
  final int playerIndex;

  const SelectActivePlayerEvent(this.playerIndex);

  @override
  List<Object?> get props => [playerIndex];
}

class ChangeActivePlayerColorEvent extends ChooseHolderEvent {
  final HolderColorOption colorOption;

  const ChangeActivePlayerColorEvent(this.colorOption);

  @override
  List<Object?> get props => [colorOption];
}
