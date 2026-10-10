import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/party_mode_selector_widget.dart';

class HolderColorOption extends Equatable {
  final String name;
  final Color color;

  const HolderColorOption({required this.name, required this.color});

  @override
  List<Object?> get props => [name, color];
}

class PartyPlayerModel extends Equatable {
  final int id;
  final String name;
  final String avatarPath;
  final bool isHost;
  final Color holderColor;
  final String holderColorName;

  const PartyPlayerModel({
    required this.id,
    required this.name,
    required this.avatarPath,
    this.isHost = false,
    this.holderColor = kHolderBlue,
    this.holderColorName = 'Blue',
  });

  PartyPlayerModel copyWith({
    int? id,
    String? name,
    String? avatarPath,
    bool? isHost,
    Color? holderColor,
    String? holderColorName,
  }) {
    return PartyPlayerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarPath: avatarPath ?? this.avatarPath,
      isHost: isHost ?? this.isHost,
      holderColor: holderColor ?? this.holderColor,
      holderColorName: holderColorName ?? this.holderColorName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        avatarPath,
        isHost,
        holderColor,
        holderColorName,
      ];
}

class CreatePartyState extends Equatable {
  final String partyName;
  final int playerCount;
  final List<PartyPlayerModel> players;
  final GameModeOption mode;
  final bool isStarting;

  const CreatePartyState({
    required this.partyName,
    required this.playerCount,
    required this.players,
    required this.mode,
    this.isStarting = false,
  });

  static const List<String> defaultNames = [
    'You',
    'Sara',
    'Ali',
    'Emma',
    'Leo',
    'Mia',
  ];

  static const List<HolderColorOption> defaultColors = [
    HolderColorOption(name: 'Blue', color: kHolderBlue),
    HolderColorOption(name: 'Green', color: kHolderGreen),
    HolderColorOption(name: 'Orange', color: kHolderOrange),
    HolderColorOption(name: 'Purple', color: kHolderPurple),
    HolderColorOption(name: 'Red', color: kHolderRed),
    HolderColorOption(name: 'Yellow', color: kHolderYellow),
  ];

  factory CreatePartyState.initial() {
    const initialCount = 4;
    final initialPlayers = List.generate(
      initialCount,
      (index) => PartyPlayerModel(
        id: index + 1,
        name: defaultNames[index],
        avatarPath: kPlayerAvatarList[index % kPlayerAvatarList.length],
        isHost: index == 0,
        holderColor: defaultColors[index % defaultColors.length].color,
        holderColorName: defaultColors[index % defaultColors.length].name,
      ),
    );

    return CreatePartyState(
      partyName: kDefaultPartyName,
      playerCount: initialCount,
      players: initialPlayers,
      mode: GameModeOption.classic,
      isStarting: false,
    );
  }

  CreatePartyState copyWith({
    String? partyName,
    int? playerCount,
    List<PartyPlayerModel>? players,
    GameModeOption? mode,
    bool? isStarting,
  }) {
    return CreatePartyState(
      partyName: partyName ?? this.partyName,
      playerCount: playerCount ?? this.playerCount,
      players: players ?? this.players,
      mode: mode ?? this.mode,
      isStarting: isStarting ?? this.isStarting,
    );
  }

  @override
  List<Object?> get props => [
        partyName,
        playerCount,
        players,
        mode,
        isStarting,
      ];
}
