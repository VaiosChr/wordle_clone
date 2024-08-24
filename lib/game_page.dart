// 3792
import 'package:flutter/material.dart';
import 'package:wordle_clone/include/classes.dart';
import 'package:wordle_clone/include/keyboard.dart';

class GamePage extends StatelessWidget {
  List<Word> words = [];

  GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          WordView(),
          WordView(),
          WordView(),
          WordView(),
          WordView(),
          KeyboardWidget(),
        ],
      ),
    );
  }
}
