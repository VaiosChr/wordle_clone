import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarChart extends StatelessWidget {
  final Map<int, int> distribution;

  const MyBarChart({super.key, required this.distribution});

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
                '${distribution[group.x + 1] ?? 0}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
        maxY: distribution.values
            .reduce((curr, next) => curr > next ? curr : next)
            .toDouble(),
        minY: 0,
        barGroups: _generateBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(7, (index) {
      int value =
          index < 7 ? (distribution[index + 1] ?? 0) : (distribution[0] ?? 0);
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
    });
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
