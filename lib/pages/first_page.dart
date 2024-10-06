import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wordle Clone',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).dialogBackgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Theme.of(context).hoverColor.withOpacity(0.1),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.show_chart,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/stats_page');
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/game_page');
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings_page');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${getMonthName(today.month)} ${today.day}, ${today.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
