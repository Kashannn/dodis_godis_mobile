import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleRewardModeEvent extends HomeEvent {
  const ToggleRewardModeEvent();
}

class SelectCategoryFilterEvent extends HomeEvent {
  final String categoryId;
  const SelectCategoryFilterEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ScanQrCodeEvent extends HomeEvent {
  final String code;
  const ScanQrCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class ResetQrScanEvent extends HomeEvent {
  const ResetQrScanEvent();
}
