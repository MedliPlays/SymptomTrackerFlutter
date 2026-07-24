import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/src/features/charts/charts_data.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';

Symptom sym(String id, String typeId, DateTime ts, {double severity = 0}) =>
    Symptom(id: id, typeId: typeId, timestamp: ts, severity: severity);

void main() {
  final typesById = {
    'H': const SymptomType(id: 'H', name: 'Headache'),
    'N': const SymptomType(id: 'N', name: 'Nausea'),
    'P': const SymptomType(id: 'P', name: 'Period', hasSeverity: false),
  };

  test('empty input yields empty ChartData', () {
    final d = ChartData.build(const [], typesById);
    expect(d.isEmpty, isTrue);
    expect(d.totalCount, 0);
    expect(d.days, isEmpty);
    expect(d.severitySymptoms, isEmpty);
  });

  test('days are dense between first and last entry', () {
    final data = ChartData.build([
      sym('1', 'H', DateTime(2026, 1, 1, 9), severity: 5),
      sym('2', 'N', DateTime(2026, 1, 3, 9), severity: 4),
    ], typesById);

    // Jan 1, Jan 2 (gap), Jan 3
    expect(data.days.map((b) => b.day), [
      DateTime(2026, 1, 1),
      DateTime(2026, 1, 2),
      DateTime(2026, 1, 3),
    ]);
    expect(data.days[1].total, 0); // the gap day
  });

  test('per-day, per-type counts', () {
    final data = ChartData.build([
      sym('1', 'H', DateTime(2026, 1, 1, 9), severity: 5),
      sym('2', 'H', DateTime(2026, 1, 1, 18), severity: 6),
      sym('3', 'N', DateTime(2026, 1, 1, 20), severity: 4),
    ], typesById);

    final day0 = data.days.first;
    expect(day0.total, 3);
    expect(day0.countByType['H'], 2);
    expect(day0.countByType['N'], 1);
  });

  test('typeCounts are largest-first', () {
    final data = ChartData.build([
      sym('1', 'H', DateTime(2026, 1, 1), severity: 5),
      sym('2', 'N', DateTime(2026, 1, 1), severity: 4),
      sym('3', 'N', DateTime(2026, 1, 2), severity: 4),
      sym('4', 'N', DateTime(2026, 1, 2), severity: 4),
    ], typesById);

    expect(data.typeCounts.map((c) => c.type.id), ['N', 'H']);
    expect(data.typeCounts.first.count, 3);
    expect(data.totalCount, 4);
  });

  test('severitySymptoms excludes non-severity types', () {
    final data = ChartData.build([
      sym('1', 'H', DateTime(2026, 1, 1), severity: 5),
      sym('2', 'P', DateTime(2026, 1, 1)), // Period: no severity
    ], typesById);

    expect(data.severitySymptoms.map((s) => s.id), ['1']);
  });

  test('unknown type id falls back to "Unknown Type"', () {
    final data = ChartData.build([
      sym('1', 'GONE', DateTime(2026, 1, 1)),
    ], typesById);
    expect(data.typeName('GONE'), 'Unknown Type');
    expect(data.typeCounts.single.type.name, 'Unknown Type');
  });
}
