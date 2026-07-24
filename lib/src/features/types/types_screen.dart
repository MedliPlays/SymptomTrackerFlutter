import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/symptom_type.dart';
import '../../providers/providers.dart';
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
    final types = ref.watch(sortedTypesProvider);
    final symptoms = ref.watch(symptomsProvider).asData?.value ?? const [];

    int usage(String id) => symptoms.where((s) => s.typeId == id).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Types')),
      floatingActionButton: types.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => _openEditor(context),
              child: const Icon(Icons.add),
            ),
      body: types.isEmpty
          ? const NoTypesView()
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
