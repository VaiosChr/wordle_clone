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
  const Color.fromARGB(255, 205, 191, 65),
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
