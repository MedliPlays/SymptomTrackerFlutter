import 'package:flutter/material.dart';

import '../../widgets/empty_state.dart';
import '../onboarding/onboarding_screen.dart';
import 'type_editor_screen.dart';

/// Shown wherever the user has no symptom types yet. Offers both a manual
/// "add a type" path and re-entry into the onboarding suggestions list.
class NoTypesView extends StatelessWidget {
  const NoTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.bolt,
      title: 'No symptom types yet',
      message:
          'Types are the things you track (like "Headache"). Add one, or pick '
          'from a list of common symptoms.',
      actions: [
        FilledButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TypeEditorScreen()),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add a type'),
        ),
        OutlinedButton.icon(
          onPressed: () => openOnboarding(context),
          icon: const Icon(Icons.list_alt),
          label: const Text('Choose from a list'),
        ),
      ],
    );
  }
}
