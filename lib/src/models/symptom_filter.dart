import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_filter.freezed.dart';

/// Filter applied to symptom lists and charts.
///
/// Each date bound is independently optional: a null [after]/[before] simply
/// isn't applied (no on/off toggle needed). [typeId] of null means "all types".
/// Date bounds are treated as inclusive whole days by the filtering logic
/// (see `matchesFilter`).
@freezed
abstract class SymptomFilter with _$SymptomFilter {
  const SymptomFilter._();

  const factory SymptomFilter({
    DateTime? after,
    DateTime? before,
    String? typeId,
  }) = _SymptomFilter;

  bool get hasDateFilter => after != null || before != null;
  bool get isSet => hasDateFilter || typeId != null;
}

/// Ordering options for the "All Symptoms" list.
enum SymptomSort {
  dateNewestFirst('Date (newest first)'),
  dateOldestFirst('Date (oldest first)'),
  typeAtoZ('Type (A–Z)'),
  typeZtoA('Type (Z–A)');

  const SymptomSort(this.label);
  final String label;
}

/// "Has severity" filter for the Types list.
enum TypeSeverityFilter {
  all('All types'),
  withSeverity('Severity tracked'),
  withoutSeverity('No severity');

  const TypeSeverityFilter(this.label);
  final String label;
}

/// Ordering options for the Types list.
enum TypeSort {
  nameAtoZ('Name (A–Z)'),
  nameZtoA('Name (Z–A)'),
  severityFirst('Severity tracked first'),
  severityLast('Severity tracked last');

  const TypeSort(this.label);
  final String label;
}
