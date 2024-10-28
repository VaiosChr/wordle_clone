import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';
import 'package:wordle_clone/include/keys.dart';
import 'package:wordle_clone/main.dart';

class KeyboardKey {
  Widget value = const Text("");
  LetterStatus status = LetterStatus.empty;

  KeyboardKey({
    required this.value,
    this.status = LetterStatus.empty,
  });
}

class KeyboardKeyView extends StatelessWidget {
  final KeyboardKey keyboardKey;
  final void Function() onTap;

  const KeyboardKeyView({
    super.key,
    required this.keyboardKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 11 - 2,
          // padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 50,
          decoration: BoxDecoration(
            color: isDarkMode
                ? darkColors[keyboardKey.status.index]
                : colors[keyboardKey.status.index],
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Theme.of(context).hoverColor.withOpacity(0.1),
              ),
            ],
          ),
          child: Center(
            child: keyboardKey.value,
          ),
        ),
      ),
    );
  }
}

class Keyboard {
  List<KeyboardKey> keys;

  Keyboard({required this.keys});

  void updateKeyColors(
      List<int> correctLetters, List<int> semiCorrectLetters, String guess) {
    for (int i = 0; i < guess.length; i++) {
      if (correctLetters.contains(i)) {
        keys[chars.indexOf(guess[i])].status = LetterStatus.green;
      } else if (semiCorrectLetters.contains(i)) {
        if (keys[chars.indexOf(guess[i])].status.index <
            LetterStatus.green.index) {
          keys[chars.indexOf(guess[i])].status = LetterStatus.yellow;
        }
      } else {
        if (keys[chars.indexOf(guess[i])].status.index <
            LetterStatus.grey.index) {
          keys[chars.indexOf(guess[i])].status = LetterStatus.grey;
        }
      }
    }
  }
}

class KeyboardView extends StatelessWidget {
  final Keyboard keyboard;

  final void Function(String) onLetterPress;
  final void Function() onEnterPress;
  final void Function() onBackspacePress;

  const KeyboardView({
    super.key,
    required this.keyboard,
    required this.onLetterPress,
    required this.onEnterPress,
    required this.onBackspacePress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 10; i++) ...{
              KeyboardKeyView(
                keyboardKey: keyboard.keys[i],
                onTap: () {
                  onLetterPress(chars[i]);
                },
              ),
            },
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 10; i < 19; i++) ...{
              KeyboardKeyView(
                keyboardKey: keyboard.keys[i],
                onTap: () {
                  onLetterPress(chars[i]);
                },
              ),
            },
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardKeyView(
              keyboardKey: KeyboardKey(
                value: Icon(
                  Icons.keyboard_return,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                status: LetterStatus.empty,
              ),
              onTap: onEnterPress,
            ),
            for (int i = 19; i < 26; i++) ...{
              KeyboardKeyView(
                keyboardKey: keyboard.keys[i],
                onTap: () {
                  onLetterPress(chars[i]);
                },
              ),
            },
            KeyboardKeyView(
              keyboardKey: KeyboardKey(
                value: Icon(
                  Icons.backspace,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                status: LetterStatus.empty,
              ),
              onTap: onBackspacePress,
            ),
          ],
        ),
      ],
    );
  }
}
