import 'package:flutter/material.dart';

enum LetterStatus {
  white,
  grey,
  yellow,
  green,
}

List<Color> colors = [
  const Color.fromARGB(255, 230, 230, 230),
  Colors.grey,
  const Color.fromARGB(255, 231, 215, 70),
  Colors.green,
];

class Letter {
  String letter = "A";
  LetterStatus status = LetterStatus.green;
}

class LetterView extends StatelessWidget {
  final Letter letter;

  const LetterView({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 5 - 15,
        height: MediaQuery.of(context).size.width / 5 - 15,
        decoration: BoxDecoration(
          color: colors[letter.status.index],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            letter.letter,
            style: const TextStyle(
              color: Colors.white,
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
}

class WordView extends StatelessWidget {
  final Word word = Word(
    letters: [
      Letter(),
      Letter(),
      Letter(),
      Letter(),
      Letter(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          word.letters.map((letter) => LetterView(letter: letter)).toList(),
    );
  }
}
