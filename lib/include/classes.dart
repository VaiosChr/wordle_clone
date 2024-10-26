import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';

class Letter {
  String letter = "";
  LetterStatus status = LetterStatus.white;
}

class LetterView extends StatelessWidget {
  final Letter letter;

  const LetterView({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width / 5 - 15,
        height: MediaQuery.of(context).size.width / 5 - 15,
        decoration: BoxDecoration(
          color: colors[letter.status.index],
          border: letter.status == LetterStatus.white
              ? Border.all(color: Colors.grey, width: 0.3)
              : null,
        ),
        child: Center(
          child: Text(
            letter.letter,
            style: TextStyle(
              color: letter.status == LetterStatus.white
                  ? Colors.black
                  : Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Word {
  List<Letter> letters = [];

  Word({
    required this.letters,
  });

  void updateLetters(List<int> correctLetters, List<int> semiCorrectLetters) {
    for (int i = 0; i < letters.length; i++) {
      if (correctLetters.contains(i)) {
        letters[i].status = LetterStatus.green;
      } else if (semiCorrectLetters.contains(i)) {
        letters[i].status = LetterStatus.yellow;
      } else {
        letters[i].status = LetterStatus.grey;
      }
    }
  }
}

class WordView extends StatelessWidget {
  final Word word;

  const WordView({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          word.letters.map((letter) => LetterView(letter: letter)).toList(),
    );
  }
}
