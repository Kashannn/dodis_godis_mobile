import 'package:flutter_bloc/flutter_bloc.dart';

import 'date_cards_event.dart';
import 'date_cards_state.dart';

class DateCardsBloc extends Bloc<DateCardsEvent, DateCardsState> {
  DateCardsBloc() : super(DateCardsState.initial()) {
    on<NextCardEvent>(_onNextCard);
    on<PreviousCardEvent>(_onPreviousCard);
    on<ChangeCategoryEvent>(_onChangeCategory);
  }

  void _onNextCard(NextCardEvent event, Emitter<DateCardsState> emit) {
    final count = state.filteredCards.length;
    if (count <= 1) return;
    emit(state.copyWith(
      currentCardIndex: (state.currentCardIndex + 1) % count,
    ));
  }

  void _onPreviousCard(PreviousCardEvent event, Emitter<DateCardsState> emit) {
    final count = state.filteredCards.length;
    if (count <= 1) return;
    final prev = state.currentCardIndex - 1;
    emit(state.copyWith(
      currentCardIndex: prev < 0 ? count - 1 : prev,
    ));
  }

  void _onChangeCategory(
    ChangeCategoryEvent event,
    Emitter<DateCardsState> emit,
  ) {
    emit(state.copyWith(
      currentCategory: event.category,
      currentCardIndex: 0,
    ));
  }
}
