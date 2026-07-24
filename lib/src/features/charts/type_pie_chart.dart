import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../util/series_color.dart';
import 'charts_data.dart';

/// Distribution of total symptoms by type. Tap a slice to highlight it and see
/// its count in the centre.
class TypePieChart extends HookWidget {
  const TypePieChart({super.key, required this.data});

  final ChartData data;

  @override
  Widget build(BuildContext context) {
    final touched = useState(-1);
    final counts = data.typeCounts;
    final total = data.totalCount;

    final sections = <PieChartSectionData>[];
    for (var i = 0; i < counts.length; i++) {
      final tc = counts[i];
      final isTouched = i == touched.value;
      final pct = total == 0 ? 0 : (tc.count / total * 100).round();
      sections.add(PieChartSectionData(
        value: tc.count.toDouble(),
        color: seriesColor(tc.type.name),
        radius: isTouched ? 74 : 64,
        title: pct >= 6 ? '$pct%' : '',
        titleStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ));
    }

    final selected = touched.value >= 0 && touched.value < counts.length
        ? counts[touched.value]
        : null;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 52,
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      if (!event.isInterestedForInteractions ||
                          response?.touchedSection == null) {
                        touched.value = -1;
                        return;
                      }
                      touched.value =
                          response!.touchedSection!.touchedSectionIndex;
                    },
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selected == null ? '$total' : '${selected.count}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    selected == null ? 'entries' : selected.type.name,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final tc in counts)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: seriesColor(tc.type.name),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('${tc.type.name} (${tc.count})',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
