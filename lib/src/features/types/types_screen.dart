import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/symptom_filter.dart';
import '../../models/symptom_type.dart';
import '../../providers/providers.dart';
import '../../widgets/empty_state.dart';
import 'no_types_view.dart';
import 'type_editor_screen.dart';

/// Manage the vocabulary of symptom types.
class TypesScreen extends ConsumerWidget {
  const TypesScreen({super.key});

  void _openEditor(BuildContext context, {SymptomType? existing}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TypeEditorScreen(existing: existing)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasAnyTypes = ref.watch(sortedTypesProvider).isNotEmpty;
    final types = ref.watch(displayedTypesProvider);
    final severityFilter = ref.watch(typesSeverityFilterProvider);
    final sort = ref.watch(typesSortOrderProvider);
    final symptoms = ref.watch(symptomsProvider).asData?.value ?? const [];

    int usage(String id) => symptoms.where((s) => s.typeId == id).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Types'),
        actions: [
          if (hasAnyTypes) ...[
            PopupMenuButton<TypeSeverityFilter>(
              tooltip: 'Filter',
              icon: Badge(
                isLabelVisible: severityFilter != TypeSeverityFilter.all,
                child: const Icon(Icons.filter_list),
              ),
              initialValue: severityFilter,
              onSelected: ref.read(typesSeverityFilterProvider.notifier).update,
              itemBuilder: (context) => [
                for (final option in TypeSeverityFilter.values)
                  PopupMenuItem(value: option, child: Text(option.label)),
              ],
            ),
            PopupMenuButton<TypeSort>(
              tooltip: 'Sort',
              icon: const Icon(Icons.sort),
              initialValue: sort,
              onSelected: ref.read(typesSortOrderProvider.notifier).update,
              itemBuilder: (context) => [
                for (final option in TypeSort.values)
                  PopupMenuItem(value: option, child: Text(option.label)),
              ],
            ),
          ],
        ],
      ),
      floatingActionButton: hasAnyTypes
          ? FloatingActionButton(
              onPressed: () => _openEditor(context),
              child: const Icon(Icons.add),
            )
          : null,
      body: !hasAnyTypes
          ? const NoTypesView()
          : types.isEmpty
              ? const EmptyState(
                  icon: Icons.filter_list_off,
                  title: 'No matches',
                  message: 'No types match this filter.',
                )
              : ListView.builder(
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    final type = types[index];
                    final count = usage(type.id);
                    return ListTile(
                      title: Text(type.name),
                      subtitle: Text(
                        '${count == 0 ? 'No' : count} '
                        '${count == 1 ? 'entry' : 'entries'}'
                        '${type.hasSeverity ? ' · severity tracked' : ''}',
                      ),
                      trailing: type.hasSeverity
                          ? const Icon(Icons.local_fire_department,
                              color: Color(0xFFEC4899))
                          : null,
                      onTap: () => _openEditor(context, existing: type),
                    );
                  },
                ),
    );
  }
}
