import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/series_color.dart';
import 'charts_data.dart';

/// Stacked bar per day, one segment per type. Scrolls horizontally so long
/// date ranges aren't squashed; tap a bar for a per-type breakdown.
class PerDayBarChart extends StatelessWidget {
  const PerDayBarChart({super.key, required this.data});

  final ChartData data;

  static const _barWidth = 16.0;
  static const _slotWidth = 34.0;
  static const _height = 240.0;

  @override
  Widget build(BuildContext context) {
    final days = data.days;
    final maxTotal =
        days.map((d) => d.total).fold(0, (a, b) => a > b ? a : b).toDouble();
    final labelEvery = (days.length / 8).ceil().clamp(1, days.length);

    final groups = <BarChartGroupData>[];
    for (var i = 0; i < days.length; i++) {
      final bucket = days[i];
      final stack = <BarChartRodStackItem>[];
      var from = 0.0;
      for (final type in data.typesPresent) {
        final count = bucket.countByType[type.id] ?? 0;
        if (count == 0) continue;
        final to = from + count;
        stack.add(BarChartRodStackItem(from, to, seriesColor(type.name)));
        from = to;
      }
      groups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: bucket.total.toDouble(),
            width: _barWidth,
            rodStackItems: stack,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
          ),
        ],
      ));
    }

    return SizedBox(
      height: _height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (days.length * _slotWidth).clamp(
              MediaQuery.of(context).size.width - 64, double.infinity),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: BarChart(
              BarChartData(
                maxY: (maxTotal < 1 ? 1 : maxTotal) * 1.15,
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final bucket = days[groupIndex];
                      final lines = <TextSpan>[];
                      for (final type in data.typesPresent) {
                        final count = bucket.countByType[type.id] ?? 0;
                        if (count == 0) continue;
                        lines.add(TextSpan(
                          text: '\n${type.name}: $count',
                          style: TextStyle(
                            color: seriesColor(type.name),
                            fontSize: 12,
                          ),
                        ));
                      }
                      return BarTooltipItem(
                        '${DateFormat.MMMd().format(bucket.day)}  ·  '
                        '${bucket.total} total',
                        const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                        children: lines,
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval:
                          maxTotal <= 5 ? 1 : (maxTotal / 5).ceilToDouble(),
                      getTitlesWidget: (value, meta) {
                        if (value != value.roundToDouble()) {
                          return const SizedBox.shrink();
                        }
                        return Text(value.toInt().toString(),
                            style: const TextStyle(fontSize: 11));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final i = value.round();
                        if (i < 0 || i >= days.length) {
                          return const SizedBox.shrink();
                        }
                        if (i % labelEvery != 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(DateFormat.Md().format(days[i].day),
                              style: const TextStyle(fontSize: 10)),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval:
                      maxTotal <= 5 ? 1 : (maxTotal / 5).ceilToDouble(),
                ),
                borderData: FlBorderData(show: false),
                barGroups: groups,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
