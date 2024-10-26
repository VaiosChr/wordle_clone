import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarChart extends StatelessWidget {
  final List<int> totalGuesses;

  const MyBarChart({super.key, required this.totalGuesses});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 30,
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${totalGuesses[group.x.toInt()]}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
        maxY: totalGuesses
            .reduce((curr, next) => curr > next ? curr : next)
            .toDouble(),
        minY: 0,
        barGroups: _generateBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return totalGuesses.asMap().entries.map(
      (entry) {
        int index = entry.key;
        int value = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value.toDouble(),
              width: 20,
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        );
      },
    ).toList();
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        (value == 6 ? "fail" : (value + 1).toInt()).toString(),
        style: style,
      ),
    );
  }
}
