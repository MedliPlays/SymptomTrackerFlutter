import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/symptom_filter.dart';
import '../../providers/providers.dart';

/// Bottom sheet for editing a [SymptomFilter]. Changes are pushed live via
/// [onChanged]. Reused by the All Symptoms list and the Charts screen.
class SymptomFilterSheet extends HookConsumerWidget {
  const SymptomFilterSheet({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  final SymptomFilter filter;
  final ValueChanged<SymptomFilter> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(sortedTypesProvider);
    final now = DateTime.now();
    final draft = useState(filter);

    void apply(SymptomFilter next) {
      draft.value = next;
      onChanged(next);
    }

    Future<void> pickDate({required bool isAfter}) async {
      final current = (isAfter ? draft.value.after : draft.value.before) ?? now;
      final picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime(2000),
        lastDate: now.add(const Duration(days: 1)),
      );
      if (picked == null) return;
      apply(isAfter
          ? draft.value.copyWith(after: picked)
          : draft.value.copyWith(before: picked));
    }

    Widget dateRow({required bool isAfter}) {
      final value = isAfter ? draft.value.after : draft.value.before;
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(isAfter ? 'After' : 'Before'),
        subtitle: Text(value == null
            ? 'Any date'
            : DateFormat.yMMMd().format(value)),
        trailing: value == null
            ? const Icon(Icons.event)
            : IconButton(
                tooltip: 'Clear',
                icon: const Icon(Icons.clear),
                onPressed: () => apply(isAfter
                    ? draft.value.copyWith(after: null)
                    : draft.value.copyWith(before: null)),
              ),
        onTap: () => pickDate(isAfter: isAfter),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Filters', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                TextButton(
                  onPressed: () => apply(const SymptomFilter()),
                  child: const Text('Reset'),
                ),
              ],
            ),
            dateRow(isAfter: true),
            dateRow(isAfter: false),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              initialValue: draft.value.typeId,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All types')),
                for (final t in types)
                  DropdownMenuItem(value: t.id, child: Text(t.name)),
              ],
              onChanged: (v) => apply(draft.value.copyWith(typeId: v)),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows the filter sheet, wiring it to [current]/[onChanged].
Future<void> showSymptomFilterSheet(
  BuildContext context, {
  required SymptomFilter current,
  required ValueChanged<SymptomFilter> onChanged,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => SymptomFilterSheet(filter: current, onChanged: onChanged),
  );
}
