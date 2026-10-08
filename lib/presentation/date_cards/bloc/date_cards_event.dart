import 'package:equatable/equatable.dart';

import '../../../data/models/date_card_model.dart';

abstract class DateCardsEvent extends Equatable {
  const DateCardsEvent();

  @override
  List<Object?> get props => [];
}

class NextCardEvent extends DateCardsEvent {
  const NextCardEvent();
}

class PreviousCardEvent extends DateCardsEvent {
  const PreviousCardEvent();
}

class ChangeCategoryEvent extends DateCardsEvent {
  final DateCardCategory category;
  const ChangeCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
