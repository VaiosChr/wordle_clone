import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';
import 'package:wordle_clone/include/keys.dart';

class KeyboardKey {
  Widget value = const Text("");
  LetterStatus status = LetterStatus.white;

  KeyboardKey({
    required this.value,
    this.status = LetterStatus.white,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 11 - 2,
          height: 50,
          decoration: BoxDecoration(
            color: colors[keyboardKey.status.index],
            borderRadius: BorderRadius.circular(5.0),
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
                value: const Icon(Icons.keyboard_return),
                status: LetterStatus.white,
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
                value: const Icon(Icons.backspace),
                status: LetterStatus.white,
              ),
              onTap: onBackspacePress,
            ),
          ],
        ),
      ],
    );
  }
}

// class KeyboardWidget extends StatefulWidget {
//   final void Function(String) onLetterPress;
//   final void Function() onEnterPress;
//   final void Function() onBackspacePress;

//   KeyboardWidget({
//     super.key,
//     required this.onLetterPress,
//     required this.onEnterPress,
//     required this.onBackspacePress,
//   });

//   @override
//   State<KeyboardWidget> createState() => _KeyboardWidgetState();
// }

// class _KeyboardWidgetState extends State<KeyboardWidget> {
//   final List<KeyWidget> _keys = [];

//   void _buildKeys() {
//     _keys.clear();
//     for (int i = 0; i < chars.length; i++) {
//       _keys.add(
//         KeyWidget(
//           value: Text(
//             chars[i],
//             style: const TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           onTap: () {
//             widget.onLetterPress(chars[i]);
//           },
//           backgroundColor: const Color.fromARGB(255, 231, 231, 231),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             for (int i = 0; i < 10; i++) ...{
//               _keys[i],
//             },
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             for (int i = 10; i < 19; i++) ...{
//               _keys[i],
//             },
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             KeyWidget(
//               value: const Icon(Icons.keyboard_return),
//               onTap: widget.onEnterPress,
//               backgroundColor: const Color.fromARGB(255, 227, 242, 253),
//             ),
//             for (int i = 19; i < 26; i++) ...{
//               _keys[i],
//             },
//             KeyWidget(
//               value: const Icon(Icons.backspace),
//               onTap: widget.onBackspacePress,
//               backgroundColor: const Color.fromARGB(255, 227, 242, 253),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void updateKeyColors(
//       List<int> correctLetters, List<int> semiCorrectLetters, String guess) {
//     setState(() {
//       for (int i = 0; i < guess.length; i++) {
//         if (correctLetters.contains(i)) {
//           _keys[chars.indexOf(guess[i])].backgroundColor = colors[3];
//         } else if (semiCorrectLetters.contains(i)) {
//           _keys[chars.indexOf(guess[i])].backgroundColor = colors[2];
//         } else {
//           _keys[chars.indexOf(guess[i])].backgroundColor = colors[1];
//         }
//       }
//       _buildKeys();
//     });
//   }
// }
