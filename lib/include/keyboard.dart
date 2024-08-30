import 'package:flutter/material.dart';
import 'package:wordle_clone/include/keys.dart';

class KeyWidget extends StatelessWidget {
  final Widget value;
  final void Function() onTap;
  final Color backgroundColor;

  const KeyWidget({
    super.key,
    required this.value,
    required this.onTap,
    required this.backgroundColor,
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
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: value,
          ),
        ),
      ),
    );
  }
}

class KeyboardWidget extends StatelessWidget {
  final void Function(String) onLetterPress;
  final void Function() onEnterPress;
  final void Function() onBackspacePress;

  const KeyboardWidget({
    super.key,
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
              KeyWidget(
                value: Text(
                  chars[i],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  onLetterPress(chars[i]);
                },
                backgroundColor: const Color.fromARGB(255, 231, 231, 231),
              ),
            },
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 10; i < 19; i++) ...{
              KeyWidget(
                value: Text(
                  chars[i],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  onLetterPress(chars[i]);
                },
                backgroundColor: const Color.fromARGB(255, 231, 231, 231),
              ),
            },
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyWidget(
              value: const Icon(Icons.keyboard_return),
              onTap: onEnterPress,
              backgroundColor: const Color.fromARGB(255, 227, 242, 253),
            ),
            for (int i = 19; i < 26; i++) ...{
              KeyWidget(
                value: Text(
                  chars[i],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  onLetterPress(chars[i]);
                },
                backgroundColor: const Color.fromARGB(255, 231, 231, 231),
              ),
            },
            KeyWidget(
              value: const Icon(Icons.backspace),
              onTap: onBackspacePress,
              backgroundColor: const Color.fromARGB(255, 227, 242, 253),
            ),
          ],
        ),
      ],
    );
  }
}
