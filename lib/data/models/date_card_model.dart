import 'package:equatable/equatable.dart';

enum DateCardCategory { icebreaker, fun, deep, naughty18 }

class DateCardModel extends Equatable {
  final String id;
  final String question;
  final String candyConsequence;
  final DateCardCategory category;

  const DateCardModel({
    required this.id,
    required this.question,
    required this.candyConsequence,
    required this.category,
  });

  @override
  List<Object?> get props => [id, question, candyConsequence, category];

  static List<DateCardModel> get sampleCards => [
    const DateCardModel(
      id: 'd1',
      question: 'What is the weirdest or funniest thing you have ever googled?',
      candyConsequence: 'Answer truthfully or surrender 1 candy!',
      category: DateCardCategory.icebreaker,
    ),
    const DateCardModel(
      id: 'd2',
      question: 'If you were a Swedish candy, which variety would you be and why?',
      candyConsequence: 'Both answer! The most creative reason wins a candy.',
      category: DateCardCategory.icebreaker,
    ),
    const DateCardModel(
      id: 'd3',
      question: 'What is your most embarrassing memory from a past date or party?',
      candyConsequence: 'Whoever refuses to answer must take 1 super sour candy (or shot).',
      category: DateCardCategory.fun,
    ),
    const DateCardModel(
      id: 'd4',
      question: 'If we could travel anywhere around the world tomorrow, where would we go first?',
      candyConsequence: 'Guess what the other person wants before revealing your answer!',
      category: DateCardCategory.deep,
    ),
    const DateCardModel(
      id: 'd5',
      question: 'What was your genuine first impression of me when we first met today?',
      candyConsequence: 'Hold eye contact for 10 seconds right after answering.',
      category: DateCardCategory.deep,
    ),
    const DateCardModel(
      id: 'd6',
      question: 'What is a secret talent or nerdy obsession you rarely tell people about?',
      candyConsequence: 'Demonstrate it or treat your date to a candy piece!',
      category: DateCardCategory.fun,
    ),
    const DateCardModel(
      id: 'd7',
      question: 'What do you find most irresistible when someone does it completely spontaneously?',
      candyConsequence: 'If you both agree, cheer with a candy toast.',
      category: DateCardCategory.naughty18,
    ),
    const DateCardModel(
      id: 'd8',
      question: 'Whisper your most forbidden or wildest romantic fantasy in the other’s ear.',
      candyConsequence: 'Whoever blushes first forfeits the candy!',
      category: DateCardCategory.naughty18,
    ),
    const DateCardModel(
      id: 'd9',
      question: 'Feed the other person a candy blindfolded!',
      candyConsequence: 'Guess the exact flavor on the first bite!',
      category: DateCardCategory.naughty18,
    ),
  ];
}
