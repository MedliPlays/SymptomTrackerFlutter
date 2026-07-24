import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/symptom.dart';
import '../../providers/providers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/symptom_tile.dart';
import '../types/no_types_view.dart';
import 'symptom_editor_screen.dart';
import 'symptom_list_actions.dart';

/// Landing screen: symptoms logged today with a quick add.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTypes = ref.watch(sortedTypesProvider).isNotEmpty;
    final today = ref.watch(todaySymptomsProvider);

    void addSymptom() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SymptomEditorScreen(initialTimestamp: DateTime.now()),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
          if (hasTypes)
            IconButton(
              tooltip: 'Log symptom',
              onPressed: addSymptom,
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: !hasTypes
          ? const NoTypesView()
          : today.isEmpty
              ? EmptyState(
                  icon: Icons.check_circle_outline,
                  title: 'No symptoms today 🎉',
                  message: 'Nothing logged yet today.',
                  actions: [
                    FilledButton.icon(
                      onPressed: addSymptom,
                      icon: const Icon(Icons.add),
                      label: const Text('Log a symptom'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: today.length,
                  itemBuilder: (context, index) {
                    final symptom = today[index];
                    return _dismissible(
                      context,
                      ref,
                      symptom,
                      child: SymptomTile(
                        symptom: symptom,
                        showDate: false,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                SymptomEditorScreen(existing: symptom),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: hasTypes && today.isNotEmpty
          ? FloatingActionButton(
              onPressed: addSymptom,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _dismissible(
    BuildContext context,
    WidgetRef ref,
    Symptom symptom, {
    required Widget child,
  }) {
    return Dismissible(
      key: ValueKey(symptom.id),
      direction: DismissDirection.endToStart,
      background: deleteSwipeBackground(context),
      onDismissed: (_) => deleteSymptomWithUndo(context, ref, symptom),
      child: child,
    );
  }
}
