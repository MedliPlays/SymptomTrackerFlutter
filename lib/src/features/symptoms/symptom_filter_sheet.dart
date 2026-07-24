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

    final after = draft.value.after ?? now.subtract(const Duration(days: 10));
    final before = draft.value.before ?? now;

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
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Filter by date'),
              value: draft.value.dateEnabled,
              onChanged: (v) => apply(draft.value.copyWith(
                dateEnabled: v,
                after: draft.value.after ?? after,
                before: draft.value.before ?? before,
              )),
            ),
            if (draft.value.dateEnabled) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('After'),
                trailing: Text(DateFormat.yMMMd().format(after)),
                onTap: () => pickDate(isAfter: true),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Before'),
                trailing: Text(DateFormat.yMMMd().format(before)),
                onTap: () => pickDate(isAfter: false),
              ),
            ],
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
