import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Widget _buildTotalGames(int wins, int losses) {
    return PieChart(
      PieChartData(
        sections: showingSections(wins, losses),
        centerSpaceRadius: 30,
      ),
    );
  }

  List<PieChartSectionData> showingSections(int wins, int losses) {
    final total = wins + losses;
    final winPercentage = (wins / total) * 100;
    final lossPercentage = (losses / total) * 100;

    return [
      PieChartSectionData(
        value: winPercentage,
        color: Colors.green,
        title: '${winPercentage.toStringAsFixed(1)}%',
        radius: 40,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: lossPercentage,
        color: Colors.grey,
        title: '${lossPercentage.toStringAsFixed(1)}%',
        radius: 40,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildAverageWins() {
    return const Text("Average Wins: 75%");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Stats',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: _buildTotalGames(120, 60));
  }
}
