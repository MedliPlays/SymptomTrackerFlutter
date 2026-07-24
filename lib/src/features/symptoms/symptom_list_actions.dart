import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/symptom.dart';
import '../../providers/providers.dart';

/// Red "delete" background revealed while swiping a symptom row.
Widget deleteSwipeBackground(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.errorContainer,
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Icon(Icons.delete,
        color: Theme.of(context).colorScheme.onErrorContainer),
  );
}

/// Deletes [symptom] and shows a SnackBar offering undo (re-inserts it).
void deleteSymptomWithUndo(BuildContext context, WidgetRef ref, Symptom symptom) {
  final repo = ref.read(symptomRepositoryProvider);
  repo.deleteSymptom(symptom.id);
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: const Text('Entry deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => repo.upsertSymptom(symptom),
      ),
    ),
  );
}
