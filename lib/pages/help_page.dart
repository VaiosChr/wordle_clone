import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('How to Play'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Wordle is a daily word guessing game. You have 6 attempts to guess a 5-letter word.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Game Rules',
              [
                'Each guess must be a valid 5-letter word',
                'After each guess, the tiles will change color to show how close your guess was to the word:',
              ],
            ),
            const SizedBox(height: 16),
            _buildColorGuide(),
            const SizedBox(height: 24),
            _buildSection(
              'Example',
              [
                'If the word is "STEAM" and you guess "SPIKE":',
              ],
            ),
            const SizedBox(height: 8),
            _buildExample(),
            const SizedBox(height: 24),
            _buildSection(
              'Tips',
              [
                'Try to use common vowels and consonants in your first guess',
                'Use the colored hints to narrow down possible letters',
                'A letter can appear multiple times in a word',
                'All words are valid English words',
              ],
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Good luck and happy guessing!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                point,
                style: const TextStyle(fontSize: 16),
              ),
            )),
      ],
    );
  }

  Widget _buildColorGuide() {
    return Column(
      children: [
        _buildColorRow(colors[LetterStatus.green.index], 'Green',
            'The letter is correct and in the right position'),
        const SizedBox(height: 8),
        _buildColorRow(colors[LetterStatus.yellow.index], 'Yellow',
            'The letter is in the word but in the wrong position'),
        const SizedBox(height: 8),
        _buildColorRow(colors[LetterStatus.grey.index], 'Grey',
            'The letter is not in the word'),
      ],
    );
  }

  Widget _buildColorRow(Color color, String colorName, String description) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$colorName: $description',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildExample() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildExampleTile('S', colors[LetterStatus.green.index]),
        _buildExampleTile('P', colors[LetterStatus.grey.index]),
        _buildExampleTile('I', colors[LetterStatus.grey.index]),
        _buildExampleTile('K', colors[LetterStatus.grey.index]),
        _buildExampleTile('E', colors[LetterStatus.yellow.index]),
      ],
    );
  }

  Widget _buildExampleTile(String letter, Color color) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
