import 'package:flutter/material.dart';
import 'package:wordle_clone/include/bar_chart.dart';
import 'package:wordle_clone/include/countdown_clock.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final int wins = 120, losses = 40;
  final List<int> totalGuesses = [0, 0, 3, 11, 37, 69, 40];

  Widget _winGauge() {
    final winRate = wins / (wins + losses);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Wins $wins%"),
            Text("Losses $losses%"),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: winRate,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation(Colors.green),
            minHeight: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildGamePerformanceStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 150,
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
                children: [
                  Text(
                    '${wins + losses}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Played'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: 150,
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
                children: [
                  Text(
                    (100 * wins / (wins + losses)).toStringAsFixed(1),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Wins %'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 150,
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
                children: [
                  Text(
                    '$wins',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Current Streak'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: 150,
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
                children: [
                  Text(
                    '$wins',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Max Streak'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGuessDistribution() {
    return MyBarChart(
      totalGuesses: totalGuesses,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "GAME PERFORMANCE",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            _buildGamePerformanceStats(),
            const SizedBox(height: 20),
            _winGauge(),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              "GUESS DISTRIBUTION",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: _buildGuessDistribution(),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              "NEXT WORDLE",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            const MidnightCountdown(),
          ],
        ),
      ),
    );
  }
}
