import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_clone/classes/statistics.dart';
import 'package:wordle_clone/classes/word_letter.dart';
import 'package:wordle_clone/components/countdown_clock.dart';
import 'package:wordle_clone/classes/keyboard.dart';
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
  bool _gamePlayable = true;

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

  late Statistics _statistics;

  @override
  void initState() {
    super.initState();
    _checkIfPlayable();
    _loadStatistics();
    _loadGameState();
  }

  Future<void> _checkIfPlayable() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPlayedDate = prefs.getInt('lastPlayedDate');

    final today = dateToInt(DateTime.now());

    _gamePlayable = lastPlayedDate == null || lastPlayedDate != today;
    _gamePlayable = true;
  }

  Future<void> _saveGamePlayableState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPlayedDate', dateToInt(DateTime.now()));
  }

  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final statsJson = prefs.getString('statistics');

    setState(() {
      if (statsJson != null) {
        _statistics = Statistics.fromJson(json.decode(statsJson));
      } else {
        _statistics = Statistics();
      }
    });
  }

  Future<void> _saveStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('statistics', json.encode(_statistics.toJson()));
  }

  Future<void> _loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    final today = dateToInt(DateTime.now());
    final gameStateJson = prefs.getString('gameState_$today');

    if (gameStateJson != null) {
      final gameState = json.decode(gameStateJson);

      setState(() {
        _row = gameState['row'];
        _col = gameState['col'];
        _currentGuess = gameState['currentGuess'];

        final wordsList = gameState['words'] as List;
        for (var i = 0; i < wordsList.length; i++) {
          final lettersList = (wordsList[i]['letters'] as List);
          for (var j = 0; j < lettersList.length; j++) {
            _words[i].letters[j].letter = lettersList[j]['letter'];
            _words[i].letters[j].status =
                LetterStatus.values[lettersList[j]['status']];
          }
        }

        final keyboardList = gameState['keyboard'] as List;
        for (var i = 0; i < keyboardList.length; i++) {
          final statusValue = keyboardList[i]['status'];
          keyboard.keys[i].status = LetterStatus.values[statusValue];
        }
      });
    }
  }

  Future<void> _saveGameState() async {
    final prefs = await SharedPreferences.getInstance();
    final gameState = {
      'row': _row,
      'col': _col,
      'currentGuess': _currentGuess,
      'words': _words
          .map((word) => {
                'letters': word.letters
                    .map((letter) => {
                          'letter': letter.letter,
                          'status': letter.status.index,
                        })
                    .toList(),
              })
          .toList(),
      'keyboard': keyboard.keys
          .map((key) => {
                'status': key.status.index,
              })
          .toList(),
    };

    await prefs.setString(
      'gameState_${dateToInt(DateTime.now())}',
      json.encode(gameState),
    );
  }

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
            _gamePlayable
                ? KeyboardView(
                    keyboard: keyboard,
                    onLetterPress: onLetterPress,
                    onEnterPress: onEnterPress,
                    onBackspacePress: onBackspacePress,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NEXT WORDLE",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      const MidnightCountdown(),
                    ],
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

  void onEnterPress() async {
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

    await checkGuess();

    setState(() {
      _row++;
      if (_row == 6) {
        _gamePlayable = false;
        _saveGamePlayableState();
      }
      _currentGuess = "";
      _col = 0;
    });

    _saveGameState();
  }

  Future<void> checkGuess() async {
    List<List<int>> result = findMatchingIndices(_wordToGuess, _currentGuess);
    List<int> correctLetters = result[0];
    List<int> semiCorrectLetters = result[1];

    _words[_row].updateLetters(correctLetters, semiCorrectLetters);
    keyboard.updateKeyColors(correctLetters, semiCorrectLetters, _currentGuess);

    bool won = _currentGuess == _wordToGuess;

    if (won) {
      _statistics.addGame(won: true, numGuesses: _row + 1);
      await _saveStatistics();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Congratulations! You guessed the word."),
        ),
      );
    } else if (_row == 5) {
      _statistics.addGame(won: false);
      await _saveStatistics();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You lost..."),
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
