import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/onboarding_items.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';

/// Welcome + "import common suggestions" experience.
///
/// Shown automatically on first launch, and reachable any time from an empty
/// Types screen ("Choose from a list"). [autoLaunched] controls the copy and
/// whether a "Not now" option is offered.
class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key, this.autoLaunched = false});

  final bool autoLaunched;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = useMemoized(buildOnboardingItems);
    final selected = useState<Set<String>>({});
    final theme = Theme.of(context);

    Future<void> finish({required bool addSelected}) async {
      final repo = ref.read(symptomRepositoryProvider);
      if (addSelected) {
        for (final preset in presets.where((p) => selected.value.contains(p.id))) {
          await repo.upsertType(preset);
        }
      }
      await repo.setOnboardingComplete();
      if (context.mounted) Navigator.of(context).pop();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite, color: brandPurple, size: 32),
                      const SizedBox(width: 12),
                      Text('Welcome to Eir',
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Eir helps you track symptoms over time and spot patterns. '
                    'Get started by picking a few common symptoms to track — you '
                    'can always add, edit or remove types later.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Suggestions', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () => selected.value =
                        presets.map((p) => p.id).toSet(),
                    child: const Text('All'),
                  ),
                  TextButton(
                    onPressed: () => selected.value = {},
                    child: const Text('None'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (final preset in presets)
                    CheckboxListTile(
                      value: selected.value.contains(preset.id),
                      onChanged: (checked) {
                        final next = {...selected.value};
                        if (checked == true) {
                          next.add(preset.id);
                        } else {
                          next.remove(preset.id);
                        }
                        selected.value = next;
                      },
                      title: Text(preset.name),
                      secondary: preset.hasSeverity
                          ? const Icon(Icons.local_fire_department,
                              color: Color(0xFFEC4899))
                          : null,
                    ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: selected.value.isEmpty
                          ? null
                          : () => finish(addSelected: true),
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48)),
                      child: Text(selected.value.isEmpty
                          ? 'Select some symptoms'
                          : 'Add ${selected.value.length} '
                              '${selected.value.length == 1 ? 'symptom' : 'symptoms'}'),
                    ),
                    TextButton(
                      onPressed: () => finish(addSelected: false),
                      child: Text(autoLaunched ? 'Not now' : 'Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pushes the onboarding flow as a full-screen route.
Future<void> openOnboarding(BuildContext context, {bool autoLaunched = false}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => OnboardingScreen(autoLaunched: autoLaunched),
    ),
  );
}
