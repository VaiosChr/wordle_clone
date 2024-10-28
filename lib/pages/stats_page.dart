import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_clone/classes/statistics.dart';
import 'package:wordle_clone/include/bar_chart.dart';
import 'package:wordle_clone/components/countdown_clock.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Statistics _statistics = Statistics();

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final statsJson = prefs.getString('statistics');

    setState(() {
      if (statsJson != null) {
        _statistics = Statistics.fromJson(json.decode(statsJson));
      } else {
        _statistics = Statistics();
      }
    });
  }

  Widget _winGauge() {
    final int wins = _statistics.totalWins;
    final int totalGames = _statistics.totalGames;
    final double winRate = totalGames == 0 ? 0 : wins / totalGames;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Wins: $wins"),
            Text("Losses: ${totalGames - wins}"),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: winRate,
            backgroundColor: Colors.grey[350],
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
                    '${_statistics.totalGames}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Games Played'),
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
                    '${(100 * _statistics.totalWins / _statistics.totalGames).toStringAsFixed(1)} %',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('Win Rate'),
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
                    _statistics.currentStreak.toString(),
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
                    _statistics.maxStreak.toString(),
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
      distribution: _statistics.guessDistribution,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
      ),
    );
  }
}
