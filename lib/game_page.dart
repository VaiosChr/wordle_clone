import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle_clone/include/classes.dart';
import 'package:wordle_clone/include/keyboard.dart';
import 'package:wordle_clone/include/words.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final String _wordToGuess =
      words[Random().nextInt(words.length)].toUpperCase();
  String _currentGuess = "";
  int _row = 0;
  int _col = 0;

  final List<Word> _words = [
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
    Word(letters: [Letter(), Letter(), Letter(), Letter(), Letter()]),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          for (int i = 0; i < _words.length; i++) ...{
            WordView(word: _words[i]),
          },
          const Spacer(),
          KeyboardWidget(
            onLetterPress: onLetterPress,
            onEnterPress: onEnterPress,
            onBackspacePress: onBackspacePress,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  void onLetterPress(String letter) {
    if (_currentGuess.length < 5) {
      setState(() {
        _currentGuess += letter;
        _words[_row].letters[_col].letter = letter;
        _col++;
      });
    }
  }

  void onEnterPress() {
    if (_currentGuess.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a 5-letter word."),
        ),
      );
      return;
    } else if (!words.contains(_currentGuess.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Not in word list."),
        ),
      );
      return;
    }

    checkGuess();

    setState(() {
      _currentGuess = "";
      _row++;
      _col = 0;
      if (_row == 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You lost..."),
          ),
        );
      }
    });
  }

  void checkGuess() {
    List<int> correctLetters = [];
    List<int> semiCorrectLetters = [];

    for (int i = 0; i < _wordToGuess.length; i++) {
      int index = _wordToGuess.indexOf(_currentGuess[i]);
      if (index != -1) {
        if (index != i) {
          semiCorrectLetters.add(i);
        } else {
          correctLetters.add(index);
        }
      }
    }

    _words[_row].updateLetters(correctLetters, semiCorrectLetters);

    if (_currentGuess == _wordToGuess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Congratulations! You guessed the word."),
        ),
      );
    }
  }

  void onBackspacePress() {
    if (_currentGuess.isNotEmpty) {
      setState(() {
        _currentGuess = _currentGuess.substring(0, _currentGuess.length - 1);
        _words[_row].letters[_col - 1].letter = "";
        _col--;
      });
    }
  }
}
