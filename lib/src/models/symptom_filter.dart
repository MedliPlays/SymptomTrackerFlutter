import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_filter.freezed.dart';

/// Filter applied to symptom lists and charts.
///
/// When [dateEnabled] is false the date bounds are ignored (all dates match).
/// [typeId] of null means "all types". Date bounds are treated as inclusive
/// whole days by the filtering logic (see `filteredSymptoms`).
@freezed
abstract class SymptomFilter with _$SymptomFilter {
  const SymptomFilter._();

  const factory SymptomFilter({
    @Default(false) bool dateEnabled,
    DateTime? after,
    DateTime? before,
    String? typeId,
  }) = _SymptomFilter;

  bool get isSet => dateEnabled || typeId != null;
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
