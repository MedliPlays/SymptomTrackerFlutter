import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/symptom_filter.dart';
import '../../providers/providers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/symptom_tile.dart';
import '../types/no_types_view.dart';
import 'symptom_editor_screen.dart';
import 'symptom_filter_sheet.dart';
import 'symptom_list_actions.dart';

/// Full symptom history with filtering and sorting.
class SymptomsScreen extends ConsumerWidget {
  const SymptomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTypes = ref.watch(sortedTypesProvider).isNotEmpty;
    final symptoms = ref.watch(filteredSymptomsProvider);
    final filter = ref.watch(symptomsFilterProvider);
    final sort = ref.watch(symptomsSortOrderProvider);

    void addSymptom() => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SymptomEditorScreen()),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Symptoms'),
        actions: [
          if (hasTypes) ...[
            IconButton(
              tooltip: 'Filter',
              onPressed: () => showSymptomFilterSheet(
                context,
                current: filter,
                onChanged: ref.read(symptomsFilterProvider.notifier).update,
              ),
              icon: Badge(
                isLabelVisible: filter.isSet,
                child: const Icon(Icons.filter_list),
              ),
            ),
            PopupMenuButton<SymptomSort>(
              tooltip: 'Sort',
              icon: const Icon(Icons.sort),
              initialValue: sort,
              onSelected: ref.read(symptomsSortOrderProvider.notifier).update,
              itemBuilder: (context) => [
                for (final option in SymptomSort.values)
                  PopupMenuItem(value: option, child: Text(option.label)),
              ],
            ),
            IconButton(
              tooltip: 'Log symptom',
              onPressed: addSymptom,
              icon: const Icon(Icons.add),
            ),
          ],
        ],
      ),
      body: !hasTypes
          ? const NoTypesView()
          : symptoms.isEmpty
              ? (filter.isSet
                  ? const EmptyState(
                      icon: Icons.filter_list_off,
                      title: 'No matches',
                      message: 'No symptoms match your current filters.',
                    )
                  : EmptyState(
                      icon: Icons.heart_broken_outlined,
                      title: 'No symptoms yet',
                      message: 'Log your first symptom to start tracking.',
                      actions: [
                        FilledButton.icon(
                          onPressed: addSymptom,
                          icon: const Icon(Icons.add),
                          label: const Text('Log a symptom'),
                        ),
                      ],
                    ))
              : ListView.builder(
                  itemCount: symptoms.length,
                  itemBuilder: (context, index) {
                    final symptom = symptoms[index];
                    return Dismissible(
                      key: ValueKey(symptom.id),
                      direction: DismissDirection.endToStart,
                      background: deleteSwipeBackground(context),
                      onDismissed: (_) =>
                          deleteSymptomWithUndo(context, ref, symptom),
                      child: SymptomTile(
                        symptom: symptom,
                        showDate: true,
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
      floatingActionButton: hasTypes && symptoms.isNotEmpty
          ? FloatingActionButton(
              onPressed: addSymptom,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
