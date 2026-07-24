import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/src/data/symptom_query.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_filter.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';

Symptom sym(String id, String typeId, DateTime ts, {double severity = 0}) =>
    Symptom(id: id, typeId: typeId, timestamp: ts, severity: severity);

SymptomType type(String id, String name, {bool hasSeverity = true}) =>
    SymptomType(id: id, name: name, hasSeverity: hasSeverity);

void main() {
  group('matchesFilter', () {
    final s = sym('1', 'A', DateTime(2026, 1, 15, 14, 30));

    test('no filter matches everything', () {
      expect(matchesFilter(s, const SymptomFilter()), isTrue);
    });

    test('type filter', () {
      expect(matchesFilter(s, const SymptomFilter(typeId: 'A')), isTrue);
      expect(matchesFilter(s, const SymptomFilter(typeId: 'B')), isFalse);
    });

    test('after bound is inclusive of the whole day', () {
      // Same day, but a later clock time than the entry — still included
      // because the bound normalises to start-of-day.
      expect(
        matchesFilter(s, SymptomFilter(after: DateTime(2026, 1, 15, 23, 0))),
        isTrue,
      );
      // Previous day boundary still includes it.
      expect(
        matchesFilter(s, SymptomFilter(after: DateTime(2026, 1, 15))),
        isTrue,
      );
      // Next day excludes it.
      expect(
        matchesFilter(s, SymptomFilter(after: DateTime(2026, 1, 16))),
        isFalse,
      );
    });

    test('before bound is inclusive of the whole day', () {
      // Earlier clock time on the same day — still included (whole day counts).
      expect(
        matchesFilter(s, SymptomFilter(before: DateTime(2026, 1, 15, 1, 0))),
        isTrue,
      );
      // Previous day excludes it.
      expect(
        matchesFilter(s, SymptomFilter(before: DateTime(2026, 1, 14))),
        isFalse,
      );
    });

    test('combined after+before range', () {
      final f = SymptomFilter(
        after: DateTime(2026, 1, 10),
        before: DateTime(2026, 1, 20),
      );
      expect(matchesFilter(s, f), isTrue);
      expect(
        matchesFilter(sym('2', 'A', DateTime(2026, 1, 21)), f),
        isFalse,
      );
      expect(
        matchesFilter(sym('3', 'A', DateTime(2026, 1, 9, 23, 59)), f),
        isFalse,
      );
    });
  });

  group('applySort', () {
    final types = {
      'A': type('A', 'Zebra'),
      'B': type('B', 'apple'),
    };
    final older = sym('old', 'A', DateTime(2026, 1, 1));
    final newer = sym('new', 'B', DateTime(2026, 2, 1));
    final list = [older, newer];

    test('date newest first', () {
      final r = applySort(list, SymptomSort.dateNewestFirst, types);
      expect(r.map((s) => s.id), ['new', 'old']);
    });

    test('date oldest first', () {
      final r = applySort(list, SymptomSort.dateOldestFirst, types);
      expect(r.map((s) => s.id), ['old', 'new']);
    });

    test('type A-Z is case-insensitive', () {
      final r = applySort(list, SymptomSort.typeAtoZ, types);
      // "apple" (B) before "Zebra" (A)
      expect(r.map((s) => s.id), ['new', 'old']);
    });

    test('type Z-A', () {
      final r = applySort(list, SymptomSort.typeZtoA, types);
      expect(r.map((s) => s.id), ['old', 'new']);
    });

    test('does not mutate the input list', () {
      final input = [older, newer];
      applySort(input, SymptomSort.dateNewestFirst, types);
      expect(input, [older, newer]);
    });
  });

  group('symptomsToday', () {
    final now = DateTime(2026, 3, 15, 12);

    test('includes today, excludes neighbours, sorts newest first', () {
      final all = [
        sym('yesterday', 'A', DateTime(2026, 3, 14, 23, 59)),
        sym('morning', 'A', DateTime(2026, 3, 15, 8)),
        sym('evening', 'A', DateTime(2026, 3, 15, 20)),
        sym('midnight', 'A', DateTime(2026, 3, 15)),
        sym('tomorrow', 'A', DateTime(2026, 3, 16)),
      ];
      final r = symptomsToday(all, now);
      expect(r.map((s) => s.id), ['evening', 'morning', 'midnight']);
    });
  });

  group('applyTypeFilterSort', () {
    final types = [
      type('1', 'Headache'),
      type('2', 'Start of menstruation', hasSeverity: false),
      type('3', 'anxiety'),
    ];

    test('filter: with severity', () {
      final r = applyTypeFilterSort(
          types, TypeSeverityFilter.withSeverity, TypeSort.nameAtoZ);
      expect(r.map((t) => t.name), ['anxiety', 'Headache']);
    });

    test('filter: without severity', () {
      final r = applyTypeFilterSort(
          types, TypeSeverityFilter.withoutSeverity, TypeSort.nameAtoZ);
      expect(r.map((t) => t.name), ['Start of menstruation']);
    });

    test('sort: name Z-A', () {
      final r = applyTypeFilterSort(
          types, TypeSeverityFilter.all, TypeSort.nameZtoA);
      expect(r.map((t) => t.name),
          ['Start of menstruation', 'Headache', 'anxiety']);
    });

    test('sort: severity first then by name', () {
      final r = applyTypeFilterSort(
          types, TypeSeverityFilter.all, TypeSort.severityFirst);
      expect(r.map((t) => t.name),
          ['anxiety', 'Headache', 'Start of menstruation']);
    });

    test('sort: severity last', () {
      final r = applyTypeFilterSort(
          types, TypeSeverityFilter.all, TypeSort.severityLast);
      expect(r.first.name, 'Start of menstruation');
    });
  });
}
