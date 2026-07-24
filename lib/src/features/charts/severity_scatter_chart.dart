import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/series_color.dart';
import 'charts_data.dart';

DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

/// A scatter spot that remembers which symptom it represents, so the tooltip
/// can show the type, date and severity.
class _SeveritySpot extends ScatterSpot {
  _SeveritySpot(
    super.x,
    super.y, {
    required this.typeName,
    required this.date,
    required Color color,
  }) : super(dotPainter: FlDotCirclePainter(radius: 6, color: color));

  final String typeName;
  final DateTime date;
}

/// Severity over time: one dot per severity-tracking symptom, coloured by
/// type. Scrolls horizontally; tap a dot for details.
class SeverityScatterChart extends StatelessWidget {
  const SeverityScatterChart({super.key, required this.data});

  final ChartData data;

  static const _slotWidth = 34.0;
  static const _height = 240.0;

  @override
  Widget build(BuildContext context) {
    final days = data.days;
    if (days.isEmpty) return const SizedBox.shrink();
    final firstDay = days.first.day;

    final spots = <_SeveritySpot>[];
    for (final s in data.severitySymptoms) {
      final dayOffset =
          _startOfDay(s.timestamp).difference(firstDay).inDays.toDouble();
      // Spread same-day/same-severity dots a touch by time-of-day.
      final x = dayOffset +
          (s.timestamp.hour * 60 + s.timestamp.minute) / 1440.0;
      final name = data.typeName(s.typeId);
      spots.add(_SeveritySpot(
        x,
        s.severity,
        typeName: name,
        date: s.timestamp,
        color: seriesColor(name),
      ));
    }

    final labelEvery = (days.length / 8).ceil().clamp(1, days.length);

    return SizedBox(
      height: _height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (days.length * _slotWidth).clamp(
              MediaQuery.of(context).size.width - 64, double.infinity),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 12),
            child: ScatterChart(
              ScatterChartData(
                minX: -0.5,
                maxX: (days.length - 1) + 0.5,
                minY: 0,
                maxY: 10,
                scatterSpots: spots,
                scatterTouchData: ScatterTouchData(
                  enabled: true,
                  touchTooltipData: ScatterTouchTooltipData(
                    fitInsideVertically: true,
                    fitInsideHorizontally: true,
                    getTooltipItems: (spot) {
                      final s = spot as _SeveritySpot;
                      return ScatterTooltipItem(
                        s.typeName,
                        textStyle: TextStyle(
                          color: seriesColor(s.typeName),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '\n${DateFormat.MMMd().add_jm().format(s.date)}'
                                '\nSeverity ${s.y.round()}/10',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
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
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        final v = value.round();
                        if (v % 2 != 0 || v < 0 || v > 10) {
                          return const SizedBox.shrink();
                        }
                        return Text(v.toString(),
                            style: const TextStyle(fontSize: 11));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final i = value.round();
                        if (i < 0 ||
                            i >= days.length ||
                            (value - i).abs() > 0.01) {
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
                gridData: const FlGridData(
                    show: true, drawVerticalLine: false, horizontalInterval: 2),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
