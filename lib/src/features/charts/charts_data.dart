import '../../models/symptom.dart';
import '../../models/symptom_type.dart';

DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

/// Per-day aggregation for one day in the range.
class DayBucket {
  DayBucket(this.day);

  final DateTime day;

  /// typeId -> count of symptoms of that type on this day.
  final Map<String, int> countByType = {};

  int get total => countByType.values.fold(0, (a, b) => a + b);
}

/// Count of instances for a single type (for the distribution pie).
class TypeCount {
  TypeCount(this.type, this.count);
  final SymptomType type;
  final int count;
}

/// Pre-computed data feeding all three charts for the current filter.
class ChartData {
  ChartData({
    required this.days,
    required this.typesPresent,
    required this.typeCounts,
    required this.severitySymptoms,
    required this.typesById,
    required this.maxSeverity,
  });

  /// Dense list of days (every day between the first and last entry) so gaps
  /// are visible and the x-axis scrolls naturally.
  final List<DayBucket> days;

  /// Types that actually appear in the filtered data (for legend/colour order).
  final List<SymptomType> typesPresent;

  /// Total count per type, largest first (for the pie).
  final List<TypeCount> typeCounts;

  /// Symptoms whose type tracks severity (for the scatter chart).
  final List<Symptom> severitySymptoms;

  final Map<String, SymptomType> typesById;
  final double maxSeverity;

  bool get isEmpty => days.isEmpty;

  int get totalCount => typeCounts.fold(0, (a, c) => a + c.count);

  String typeName(String? id) => typesById[id]?.name ?? 'Unknown Type';

  static ChartData build(
    List<Symptom> symptoms,
    Map<String, SymptomType> typesById,
  ) {
    if (symptoms.isEmpty) {
      return ChartData(
        days: const [],
        typesPresent: const [],
        typeCounts: const [],
        severitySymptoms: const [],
        typesById: typesById,
        maxSeverity: 10,
      );
    }

    // Dense day range from first to last entry.
    final sorted = [...symptoms]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    final first = _startOfDay(sorted.first.timestamp);
    final last = _startOfDay(sorted.last.timestamp);

    final days = <DayBucket>[];
    final index = <DateTime, DayBucket>{};
    for (var d = first;
        !d.isAfter(last);
        d = d.add(const Duration(days: 1))) {
      final bucket = DayBucket(d);
      days.add(bucket);
      index[d] = bucket;
    }

    final counts = <String, int>{};
    for (final s in symptoms) {
      index[_startOfDay(s.timestamp)]!.countByType.update(
            s.typeId,
            (v) => v + 1,
            ifAbsent: () => 1,
          );
      counts.update(s.typeId, (v) => v + 1, ifAbsent: () => 1);
    }

    final typeCounts = counts.entries
        .map((e) => TypeCount(
            typesById[e.key] ??
                SymptomType(id: e.key, name: 'Unknown Type', hasSeverity: false),
            e.value))
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));

    final typesPresent = typeCounts.map((c) => c.type).toList();

    final severitySymptoms = symptoms
        .where((s) => typesById[s.typeId]?.hasSeverity ?? false)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return ChartData(
      days: days,
      typesPresent: typesPresent,
      typeCounts: typeCounts,
      severitySymptoms: severitySymptoms,
      typesById: typesById,
      maxSeverity: 10,
    );
  }
}
