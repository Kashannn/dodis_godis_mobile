import 'package:equatable/equatable.dart';

import '../../../data/models/game_category_model.dart';

enum RewardMode { candy, shot }

class HomeState extends Equatable {
  final RewardMode rewardMode;
  final String selectedCategoryId; // 'all' or specific id
  final List<GameCategoryModel> categories;
  final bool isQrScanning;
  final String? scannedGameTarget;

  const HomeState({
    required this.rewardMode,
    required this.selectedCategoryId,
    required this.categories,
    this.isQrScanning = false,
    this.scannedGameTarget,
  });

  factory HomeState.initial() {
    return HomeState(
      rewardMode: RewardMode.candy,
      selectedCategoryId: 'all',
      categories: GameCategoryModel.sampleCategories,
      isQrScanning: false,
      scannedGameTarget: null,
    );
  }

  HomeState copyWith({
    RewardMode? rewardMode,
    String? selectedCategoryId,
    List<GameCategoryModel>? categories,
    bool? isQrScanning,
    String? scannedGameTarget,
  }) {
    return HomeState(
      rewardMode: rewardMode ?? this.rewardMode,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
      isQrScanning: isQrScanning ?? this.isQrScanning,
      scannedGameTarget: scannedGameTarget ?? this.scannedGameTarget,
    );
  }

  @override
  List<Object?> get props => [
    rewardMode,
    selectedCategoryId,
    categories,
    isQrScanning,
    scannedGameTarget,
  ];
}
