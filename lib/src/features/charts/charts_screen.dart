import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/empty_state.dart';
import '../symptoms/symptom_filter_sheet.dart';
import '../types/no_types_view.dart';
import 'charts_data.dart';
import 'per_day_bar_chart.dart';
import 'severity_scatter_chart.dart';
import 'type_pie_chart.dart';

/// Charts screen: per-day totals, severity over time, and type distribution.
class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTypes = ref.watch(sortedTypesProvider).isNotEmpty;
    final filter = ref.watch(chartsFilterProvider);
    final data = ChartData.build(
      ref.watch(chartSymptomsProvider),
      ref.watch(typesByIdProvider),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
        actions: [
          if (hasTypes)
            IconButton(
              tooltip: 'Filter',
              onPressed: () => showSymptomFilterSheet(
                context,
                current: filter,
                onChanged: ref.read(chartsFilterProvider.notifier).update,
              ),
              icon: Badge(
                isLabelVisible: filter.isSet,
                child: const Icon(Icons.filter_list),
              ),
            ),
        ],
      ),
      body: !hasTypes
          ? const NoTypesView()
          : data.isEmpty
              ? const EmptyState(
                  icon: Icons.insights,
                  title: 'Nothing to chart yet',
                  message:
                      'Log some symptoms (or widen the date filter) to see '
                      'your trends here.',
                )
              : ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    _ChartCard(
                      icon: Icons.bar_chart,
                      title: 'Symptoms per day',
                      subtitle: 'Tap a bar for a breakdown · scroll for history',
                      child: PerDayBarChart(data: data),
                    ),
                    if (data.severitySymptoms.isNotEmpty)
                      _ChartCard(
                        icon: Icons.local_fire_department,
                        title: 'Severity over time',
                        subtitle: 'Tap a point for details',
                        child: SeverityScatterChart(data: data),
                      ),
                    _ChartCard(
                      icon: Icons.pie_chart,
                      title: 'By type',
                      subtitle: 'Tap a slice to highlight it',
                      child: TypePieChart(data: data),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(title, style: theme.textTheme.titleMedium),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 2),
              child: Text(subtitle,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
