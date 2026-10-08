import 'package:equatable/equatable.dart';

import '../../../data/models/date_card_model.dart';

class DateCardsState extends Equatable {
  final List<DateCardModel> allCards;
  final DateCardCategory currentCategory;
  final int currentCardIndex;

  const DateCardsState({
    required this.allCards,
    required this.currentCategory,
    required this.currentCardIndex,
  });

  factory DateCardsState.initial() {
    return DateCardsState(
      allCards: DateCardModel.sampleCards,
      currentCategory: DateCardCategory.icebreaker,
      currentCardIndex: 0,
    );
  }

  List<DateCardModel> get filteredCards =>
      allCards.where((c) => c.category == currentCategory).toList();

  DateCardModel? get currentCard {
    final list = filteredCards;
    if (list.isEmpty) return null;
    return list[currentCardIndex % list.length];
  }

  DateCardsState copyWith({
    List<DateCardModel>? allCards,
    DateCardCategory? currentCategory,
    int? currentCardIndex,
  }) {
    return DateCardsState(
      allCards: allCards ?? this.allCards,
      currentCategory: currentCategory ?? this.currentCategory,
      currentCardIndex: currentCardIndex ?? this.currentCardIndex,
    );
  }

  @override
  List<Object?> get props => [allCards, currentCategory, currentCardIndex];
}
