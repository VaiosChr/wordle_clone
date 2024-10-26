import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordle_clone/include/words.dart';

enum LetterStatus {
  white,
  grey,
  yellow,
  green,
}

List<Color> colors = [
  Colors.white,
  Colors.grey,
  Colors.yellow,
  Colors.green,
];

String getWordOftheDay() {
  final now = DateTime.now();
  final seed = now.year * 10000 + now.month * 100 + now.day;
  final random = Random(seed);

  return words[random.nextInt(words.length)].toUpperCase();
}

List<List<int>> findMatchingIndices(String wordToGuess, String currentGuess) {
  List<int> correctLetters = [];
  List<int> semiCorrectLetters = [];

  for (int i = 0; i < wordToGuess.length; i++) {
    List<int> matchingIndices = wordToGuess
        .split('')
        .asMap()
        .entries
        .where((entry) => entry.value == currentGuess[i])
        .map((entry) => entry.key)
        .toList();

    if (matchingIndices.isNotEmpty) {
      if (matchingIndices.contains(i)) {
        correctLetters.add(i);
      } else {
        semiCorrectLetters.add(i);
      }
    }
  }

  return [correctLetters, semiCorrectLetters];
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
