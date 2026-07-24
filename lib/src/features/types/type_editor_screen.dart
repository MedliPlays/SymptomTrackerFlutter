import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/symptom_type.dart';
import '../../providers/providers.dart';

const _uuid = Uuid();

/// Add or edit a [SymptomType]. Pass [existing] to edit, or null to create.
class TypeEditorScreen extends HookConsumerWidget {
  const TypeEditorScreen({super.key, this.existing});

  final SymptomType? existing;

  bool get isEditing => existing != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: existing?.name ?? '');
    final hasSeverity = useState(existing?.hasSeverity ?? true);
    // Rebuild when the name changes so Save enables/disables live.
    final name = useListenableSelector(nameController, () => nameController.text);

    bool isDirty() {
      if (!isEditing) return name.trim().isNotEmpty;
      return name.trim() != existing!.name || hasSeverity.value != existing!.hasSeverity;
    }

    final canSave = name.trim().isNotEmpty;

    // How many symptoms use this type — deletion is only allowed when none do.
    final usageCount = isEditing
        ? (ref.watch(symptomsProvider).asData?.value ?? const [])
            .where((s) => s.typeId == existing!.id)
            .length
        : 0;

    Future<void> save() async {
      final repo = ref.read(symptomRepositoryProvider);
      final type = SymptomType(
        id: existing?.id ?? _uuid.v4().toUpperCase(),
        name: name.trim(),
        hasSeverity: hasSeverity.value,
      );
      await repo.upsertType(type);
      if (context.mounted) Navigator.of(context).pop();
    }

    Future<void> confirmDelete() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete type?'),
          content: Text('Delete "${existing!.name}"? This can\'t be undone.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton.tonal(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
      if (ok == true) {
        await ref.read(symptomRepositoryProvider).deleteType(existing!.id);
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
          title: Text(isEditing ? 'Edit Type' : 'New Type'),
          actions: [
            TextButton(
              onPressed: canSave ? save : null,
              child: const Text('Save'),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: nameController,
                autofocus: !isEditing,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'e.g. Headache',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  if (canSave) save();
                },
              ),
            ),
            SwitchListTile(
              value: hasSeverity.value,
              onChanged: (v) => hasSeverity.value = v,
              title: const Text('Track severity'),
              subtitle: const Text(
                  'Show a 1–10 severity slider when logging this symptom.'),
            ),
            if (isEditing) ...[
              const Divider(height: 32),
              if (usageCount == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton.icon(
                    onPressed: confirmDelete,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete type'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'In use by $usageCount ${usageCount == 1 ? 'symptom' : 'symptoms'}. '
                    'Delete or reassign those before removing this type.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
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
