import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/symptom.dart';
import '../providers/providers.dart';
import '../util/series_color.dart';
import 'severity_badge.dart';

/// A single symptom row used by the Today and All Symptoms lists.
class SymptomTile extends ConsumerWidget {
  const SymptomTile({
    super.key,
    required this.symptom,
    required this.showDate,
    this.onTap,
  });

  final Symptom symptom;

  /// When true, the subtitle includes the date (used in the full history);
  /// when false only the time is shown (used in Today).
  final bool showDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(typesByIdProvider)[symptom.typeId];
    final name = type?.name ?? 'Unknown Type';
    final hasSeverity = type?.hasSeverity ?? false;

    final time = DateFormat.jm().format(symptom.timestamp);
    final subtitle =
        showDate ? '${DateFormat.yMMMd().format(symptom.timestamp)} · $time' : time;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 6,
        backgroundColor: seriesColor(name),
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasSeverity) SeverityBadge(severity: symptom.severity),
          if (symptom.notes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.sticky_note_2_outlined,
                  size: 18, color: Theme.of(context).colorScheme.outline),
            ),
        ],
      ),
    );
  }
}
