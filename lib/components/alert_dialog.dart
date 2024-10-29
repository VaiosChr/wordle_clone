import 'package:flutter/material.dart';
import 'package:wordle_clone/components/custom_container.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final int streak;
  final int guesses;
  final String word;

  const CustomDialog({
    super.key,
    this.title = 'Congratulations!',
    this.message = 'You won the game!',
    this.streak = 0,
    this.guesses = 0,
    this.word = '',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WORD:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  word,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'GUESSES:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '$guesses',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CURRENT STREAK:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '$streak',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
