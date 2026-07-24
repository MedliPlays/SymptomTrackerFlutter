import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symptom_tracker/src/features/onboarding/onboarding_screen.dart';
import 'package:symptom_tracker/src/features/symptoms/today_screen.dart';
import 'package:symptom_tracker/src/features/types/types_screen.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';
import 'package:symptom_tracker/src/providers/providers.dart';

/// Widget tests exercise real widgets + the Riverpod graph. The base data
/// stream providers are overridden with single-value streams so tests are
/// deterministic and independent of the on-device database (and of chart
/// animations — screens are pumped individually).

final _type = const SymptomType(id: 'A', name: 'Headache');
final _symptom = Symptom(
  id: 's1',
  typeId: 'A',
  timestamp: DateTime.now(),
  severity: 6,
);

Widget wrap(Widget child, {List<SymptomType>? types, List<Symptom>? symptoms}) {
  return ProviderScope(
    overrides: [
      symptomTypesProvider.overrideWith((ref) => Stream.value(types ?? [_type])),
      symptomsProvider
          .overrideWith((ref) => Stream.value(symptoms ?? [_symptom])),
    ],
    child: MaterialApp(home: child),
  );
}

void main() {
  testWidgets('Today lists an entry logged today', (tester) async {
    await tester.pumpWidget(wrap(const TodayScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Headache'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget); // FAB
  });

  testWidgets('Today shows a friendly empty state with no entries today',
      (tester) async {
    await tester.pumpWidget(wrap(const TodayScreen(), symptoms: []));
    await tester.pumpAndSettle();

    expect(find.textContaining('No symptoms today'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget); // FAB still present
  });

  testWidgets('Types lists the type with a FAB and no toolbar add',
      (tester) async {
    await tester.pumpWidget(wrap(const TypesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Headache'), findsOneWidget);
    // Single add affordance (the FAB), plus filter + sort controls.
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.filter_list), findsOneWidget);
    expect(find.byIcon(Icons.sort), findsOneWidget);
  });

  testWidgets('Onboarding shows welcome and suggestions', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: OnboardingScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Eir'), findsOneWidget);
    expect(find.text('Headache'), findsWidgets); // a suggestion row
    // Add button is disabled until at least one suggestion is selected.
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Select some symptoms'),
    );
    expect(button.onPressed, isNull);
  });
}
