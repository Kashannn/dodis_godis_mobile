import 'package:equatable/equatable.dart';

class YatzyPlayer extends Equatable {
  final String name;
  final Map<String, int?> scores; // categoryId -> score (null means unrecorded)

  const YatzyPlayer({
    required this.name,
    required this.scores,
  });

  factory YatzyPlayer.initial(String name) {
    return YatzyPlayer(
      name: name,
      scores: const {},
    );
  }

  int get upperSectionSum {
    int sum = 0;
    for (final key in ['ettor', 'tvaor', 'treor', 'fyror', 'femmor', 'sexor']) {
      sum += scores[key] ?? 0;
    }
    return sum;
  }

  int get bonus => upperSectionSum >= 63 ? 50 : 0;

  int get lowerSectionSum {
    int sum = 0;
    for (final key in [
      'ett_par',
      'tva_par',
      'tretal',
      'fyrtal',
      'liten_stege',
      'stor_stege',
      'kak',
      'chans',
      'yatzy',
    ]) {
      sum += scores[key] ?? 0;
    }
    return sum;
  }

  int get totalScore => upperSectionSum + bonus + lowerSectionSum;

  YatzyPlayer copyWith({
    String? name,
    Map<String, int?>? scores,
  }) {
    return YatzyPlayer(
      name: name ?? this.name,
      scores: scores ?? Map.from(this.scores),
    );
  }

  @override
  List<Object?> get props => [name, scores];
}

class YatzyCategory {
  final String id;
  final String label;
  final bool isUpper;

  const YatzyCategory({
    required this.id,
    required this.label,
    required this.isUpper,
  });

  static const List<YatzyCategory> upperCategories = [
    YatzyCategory(id: 'ettor', label: 'Ones', isUpper: true),
    YatzyCategory(id: 'tvaor', label: 'Twos', isUpper: true),
    YatzyCategory(id: 'treor', label: 'Threes', isUpper: true),
    YatzyCategory(id: 'fyror', label: 'Fours', isUpper: true),
    YatzyCategory(id: 'femmor', label: 'Fives', isUpper: true),
    YatzyCategory(id: 'sexor', label: 'Sixes', isUpper: true),
  ];

  static const List<YatzyCategory> lowerCategories = [
    YatzyCategory(id: 'ett_par', label: 'One Pair', isUpper: false),
    YatzyCategory(id: 'tva_par', label: 'Two Pairs', isUpper: false),
    YatzyCategory(id: 'tretal', label: 'Three of a Kind', isUpper: false),
    YatzyCategory(id: 'fyrtal', label: 'Four of a Kind', isUpper: false),
    YatzyCategory(id: 'liten_stege', label: 'Small Straight', isUpper: false),
    YatzyCategory(id: 'stor_stege', label: 'Large Straight', isUpper: false),
    YatzyCategory(id: 'kak', label: 'Full House', isUpper: false),
    YatzyCategory(id: 'chans', label: 'Chance', isUpper: false),
    YatzyCategory(id: 'yatzy', label: 'Yatzy (50p)', isUpper: false),
  ];
}
