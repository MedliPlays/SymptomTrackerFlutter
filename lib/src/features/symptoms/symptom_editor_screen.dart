import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../models/symptom.dart';
import '../../providers/providers.dart';

const _uuid = Uuid();

/// Add or edit a [Symptom] instance. Pass [existing] to edit.
/// [initialTimestamp] seeds the date for new entries (e.g. from Today).
class SymptomEditorScreen extends HookConsumerWidget {
  const SymptomEditorScreen({super.key, this.existing, this.initialTimestamp});

  final Symptom? existing;
  final DateTime? initialTimestamp;

  bool get isEditing => existing != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(sortedTypesProvider);

    final timestamp =
        useState(existing?.timestamp ?? initialTimestamp ?? DateTime.now());
    final typeId = useState<String?>(existing?.typeId);
    final severity = useState<double>(existing?.severity ?? 5);
    final notesController = useTextEditingController(text: existing?.notes ?? '');
    final notes = useListenableSelector(notesController, () => notesController.text);

    final selectedType =
        types.where((t) => t.id == typeId.value).firstOrNull;
    final showSeverity = selectedType?.hasSeverity ?? false;
    final canSave = typeId.value != null;

    bool isDirty() {
      if (!isEditing) return true;
      return timestamp.value != existing!.timestamp ||
          typeId.value != existing!.typeId ||
          severity.value != existing!.severity ||
          notes != existing!.notes;
    }

    Future<void> pickDateTime() async {
      final date = await showDatePicker(
        context: context,
        initialDate: timestamp.value,
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 1)),
      );
      if (date == null || !context.mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(timestamp.value),
      );
      final t = time ?? TimeOfDay.fromDateTime(timestamp.value);
      timestamp.value =
          DateTime(date.year, date.month, date.day, t.hour, t.minute);
    }

    Future<void> save() async {
      final type = selectedType!;
      final symptom = Symptom(
        id: existing?.id ?? _uuid.v4(),
        timestamp: timestamp.value,
        typeId: type.id,
        severity: type.hasSeverity ? severity.value : 0,
        notes: notes.trim(),
      );
      await ref.read(symptomRepositoryProvider).upsertSymptom(symptom);
      if (context.mounted) Navigator.of(context).pop();
    }

    Future<void> confirmDelete() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete entry?'),
          content: const Text('This symptom entry will be removed.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton.tonal(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete')),
          ],
        ),
      );
      if (ok == true) {
        await ref.read(symptomRepositoryProvider).deleteSymptom(existing!.id);
        if (context.mounted) Navigator.of(context).pop();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (!isDirty() || await _confirmDiscard(context)) {
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Symptom' : 'Log Symptom'),
          actions: [
            TextButton(onPressed: canSave ? save : null, child: const Text('Save')),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Date & time'),
              subtitle: Text(
                  DateFormat.yMMMEd().add_jm().format(timestamp.value)),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: pickDateTime,
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: DropdownButtonFormField<String>(
                initialValue: typeId.value,
                decoration: const InputDecoration(
                  labelText: 'Symptom type',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final t in types)
                    DropdownMenuItem(value: t.id, child: Text(t.name)),
                ],
                onChanged: (v) => typeId.value = v,
              ),
            ),
            if (showSeverity) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    const Text('Severity'),
                    const Spacer(),
                    Text('${severity.value.round()} / 10',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Slider(
                value: severity.value.clamp(1, 10),
                min: 1,
                max: 10,
                divisions: 9,
                label: severity.value.round().toString(),
                onChanged: (v) => severity.value = v,
              ),
            ],
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: notesController,
                minLines: 3,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            if (isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OutlinedButton.icon(
                  onPressed: confirmDelete,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete entry'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _confirmDiscard(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Discard changes?'),
      content: const Text('Your unsaved changes will be lost.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep editing')),
        FilledButton.tonal(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard')),
      ],
    ),
  );
  return result ?? false;
}
