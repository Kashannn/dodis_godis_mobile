import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<ToggleRewardModeEvent>(_onToggleRewardMode);
    on<SelectCategoryFilterEvent>(_onSelectCategoryFilter);
    on<ScanQrCodeEvent>(_onScanQrCode);
    on<ResetQrScanEvent>(_onResetQrScan);
  }

  void _onToggleRewardMode(ToggleRewardModeEvent event, Emitter<HomeState> emit) {
    final newMode = state.rewardMode == RewardMode.candy
        ? RewardMode.shot
        : RewardMode.candy;
    emit(state.copyWith(rewardMode: newMode));
  }

  void _onSelectCategoryFilter(
    SelectCategoryFilterEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void _onScanQrCode(ScanQrCodeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      isQrScanning: false,
      scannedGameTarget: event.code,
    ));
  }

  void _onResetQrScan(ResetQrScanEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(scannedGameTarget: null));
  }
}
