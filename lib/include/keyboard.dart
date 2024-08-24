import 'package:flutter/material.dart';
import 'package:wordle_clone/include/keys.dart';

class KeyWidget extends StatelessWidget {
  final String value;

  const KeyWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          // handle key press
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 11 - 2,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 231, 231),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionKey extends StatelessWidget {
  final Icon icon;
  final void Function() onTap;

  const ActionKey({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 11 - 2,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

class KeyboardWidget extends StatelessWidget {
  final List<KeyWidget> keys = List<KeyWidget>.generate(26, (index) {
    return KeyWidget(value: chars[index]);
  });

  KeyboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 10; i++) ...{keys[i]},
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 10; i < 19; i++) ...{keys[i]},
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionKey(
              icon: const Icon(Icons.keyboard_return),
              onTap: () {},
            ),
            for (int i = 19; i < 26; i++) ...{keys[i]},
            ActionKey(
              icon: const Icon(Icons.backspace),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
