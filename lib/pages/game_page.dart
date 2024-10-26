import 'package:flutter/material.dart';
import 'package:wordle_clone/include/classes.dart';
import 'package:wordle_clone/include/keyboard.dart';
import 'package:wordle_clone/include/keys.dart';
import 'package:wordle_clone/include/words.dart';
import 'package:wordle_clone/include/helpers.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String _currentGuess = "";
  int _row = 0, _col = 0;

  final String _wordToGuess = getWordOftheDay();

  final List<Word> _words = List.generate(
    6,
    (index) => Word(
      letters: List.generate(
        5,
        (index) => Letter(),
      ),
    ),
  );

  final Keyboard keyboard = Keyboard(
    keys: List.generate(
      26,
      (index) => KeyboardKey(
        value: Text(
          chars[index],
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Wordle Clone',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            for (int i = 0; i < _words.length; i++) ...{
              WordView(word: _words[i]),
            },
            const Spacer(),
            KeyboardView(
              keyboard: keyboard,
              onLetterPress: onLetterPress,
              onEnterPress: onEnterPress,
              onBackspacePress: onBackspacePress,
            ),
            const SizedBox(height: 25),
          ],
        ),
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
    List<List<int>> result = findMatchingIndices(_wordToGuess, _currentGuess);
    List<int> correctLetters = result[0];
    List<int> semiCorrectLetters = result[1];

    _words[_row].updateLetters(correctLetters, semiCorrectLetters);
    keyboard.updateKeyColors(correctLetters, semiCorrectLetters, _currentGuess);

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
