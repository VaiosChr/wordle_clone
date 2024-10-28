import 'package:flutter/material.dart';
import 'package:wordle_clone/components/custom_container.dart';
import 'package:wordle_clone/include/helpers.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Wordle Clone',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/home_page3.png')),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.titleLarge,
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
                            Icons.settings_outlined,
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
        ],
      ),
    );
  }
}
