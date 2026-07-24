import '../models/symptom.dart';
import '../models/symptom_filter.dart';
import '../models/symptom_type.dart';

/// Pure filtering/sorting helpers shared by the symptom list and the charts.

DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

/// Whether [s] matches [filter].
///
/// Date bounds are inclusive whole days: `after` and `before` both include
/// their entire day, i.e. the range is
/// `[startOfDay(after), startOfDay(before) + 1 day)`.
bool matchesFilter(Symptom s, SymptomFilter filter) {
  if (filter.typeId != null && s.typeId != filter.typeId) return false;
  final after = filter.after;
  if (after != null && s.timestamp.isBefore(_startOfDay(after))) {
    return false;
  }
  final before = filter.before;
  if (before != null) {
    final endExclusive = _startOfDay(before).add(const Duration(days: 1));
    if (!s.timestamp.isBefore(endExclusive)) return false;
  }
  return true;
}

List<Symptom> applyFilter(List<Symptom> symptoms, SymptomFilter filter) =>
    symptoms.where((s) => matchesFilter(s, filter)).toList();

/// Sorts a copy of [symptoms] by [sort]. Type ordering uses the type name
/// resolved via [typesById]; a missing type sorts as "Unknown Type".
List<Symptom> applySort(
  List<Symptom> symptoms,
  SymptomSort sort,
  Map<String, SymptomType> typesById,
) {
  String typeName(Symptom s) =>
      typesById[s.typeId]?.name ?? 'Unknown Type';

  final sorted = [...symptoms];
  switch (sort) {
    case SymptomSort.dateNewestFirst:
      sorted.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    case SymptomSort.dateOldestFirst:
      sorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    case SymptomSort.typeAtoZ:
      sorted.sort((a, b) => typeName(a)
          .toLowerCase()
          .compareTo(typeName(b).toLowerCase()));
    case SymptomSort.typeZtoA:
      sorted.sort((a, b) => typeName(b)
          .toLowerCase()
          .compareTo(typeName(a).toLowerCase()));
  }
  return sorted;
}

/// Symptoms logged today (used by the Today screen and its badge).
List<Symptom> symptomsToday(List<Symptom> symptoms, DateTime now) {
  final start = _startOfDay(now);
  final end = start.add(const Duration(days: 1));
  return symptoms
      .where((s) => !s.timestamp.isBefore(start) && s.timestamp.isBefore(end))
      .toList()
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
}
