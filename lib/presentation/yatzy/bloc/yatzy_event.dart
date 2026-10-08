import 'package:equatable/equatable.dart';

abstract class YatzyEvent extends Equatable {
  const YatzyEvent();

  @override
  List<Object?> get props => [];
}

class RollYatzyDiceEvent extends YatzyEvent {
  const RollYatzyDiceEvent();
}

class ToggleHoldDieEvent extends YatzyEvent {
  final int dieIndex;
  const ToggleHoldDieEvent(this.dieIndex);

  @override
  List<Object?> get props => [dieIndex];
}

class RecordScoreEvent extends YatzyEvent {
  final String categoryId;
  const RecordScoreEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ResetYatzyGameEvent extends YatzyEvent {
  const ResetYatzyGameEvent();
}
