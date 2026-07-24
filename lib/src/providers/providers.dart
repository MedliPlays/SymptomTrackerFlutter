import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';

import '../data/backup_service.dart';
import '../data/symptom_query.dart';
import '../data/symptom_repository.dart';
import '../models/symptom.dart';
import '../models/symptom_filter.dart';
import '../models/symptom_type.dart';

part 'providers.g.dart';

/// The opened sembast database. Overridden with the real instance in `main`
/// once [openAppDatabase] has completed.
@Riverpod(keepAlive: true)
Database database(Ref ref) =>
    throw UnimplementedError('databaseProvider must be overridden in main()');

@Riverpod(keepAlive: true)
SymptomRepository symptomRepository(Ref ref) =>
    SymptomRepository(ref.watch(databaseProvider));

@riverpod
BackupService backupService(Ref ref) =>
    BackupService(ref.watch(symptomRepositoryProvider));

/// Whether the user has completed (or skipped) first-launch onboarding.
@riverpod
Future<bool> onboardingCompleted(Ref ref) =>
    ref.watch(symptomRepositoryProvider).hasCompletedOnboarding();

// ---- Reactive base data -----------------------------------------------------

@riverpod
Stream<List<SymptomType>> symptomTypes(Ref ref) =>
    ref.watch(symptomRepositoryProvider).watchTypes();

@riverpod
Stream<List<Symptom>> symptoms(Ref ref) =>
    ref.watch(symptomRepositoryProvider).watchSymptoms();

/// Types keyed by id, for quick lookup when rendering/sorting.
@riverpod
Map<String, SymptomType> typesById(Ref ref) {
  final types = ref.watch(symptomTypesProvider).asData?.value ?? const [];
  return {for (final t in types) t.id: t};
}

/// Types sorted by name (A–Z) for pickers and the Types list.
@riverpod
List<SymptomType> sortedTypes(Ref ref) {
  final types = List<SymptomType>.of(
      ref.watch(symptomTypesProvider).asData?.value ?? const []);
  types.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return types;
}

// ---- Filter + sort state ----------------------------------------------------

/// Filter for the "All Symptoms" list. Defaults to no date filter (all dates).
@riverpod
class SymptomsFilter extends _$SymptomsFilter {
  @override
  SymptomFilter build() => const SymptomFilter();

  void update(SymptomFilter filter) => state = filter;
  void reset() => state = const SymptomFilter();
}

/// Filter for the Charts screen. Defaults to a rolling 10-day window, matching
/// the original app.
@riverpod
class ChartsFilter extends _$ChartsFilter {
  @override
  SymptomFilter build() {
    final now = DateTime.now();
    return SymptomFilter(
      after: now.subtract(const Duration(days: 10)),
      before: now,
    );
  }

  void update(SymptomFilter filter) => state = filter;
}

@riverpod
class SymptomsSortOrder extends _$SymptomsSortOrder {
  @override
  SymptomSort build() => SymptomSort.dateNewestFirst;

  void update(SymptomSort sort) => state = sort;
}

@riverpod
class TypesSeverityFilter extends _$TypesSeverityFilter {
  @override
  TypeSeverityFilter build() => TypeSeverityFilter.all;

  void update(TypeSeverityFilter filter) => state = filter;
}

@riverpod
class TypesSortOrder extends _$TypesSortOrder {
  @override
  TypeSort build() => TypeSort.nameAtoZ;

  void update(TypeSort sort) => state = sort;
}

/// Types after applying the Types-list filter + sort.
@riverpod
List<SymptomType> displayedTypes(Ref ref) {
  final all = ref.watch(symptomTypesProvider).asData?.value ?? const [];
  return applyTypeFilterSort(
    all,
    ref.watch(typesSeverityFilterProvider),
    ref.watch(typesSortOrderProvider),
  );
}

// ---- Derived lists ----------------------------------------------------------

/// Symptoms after applying the list filter + sort order.
@riverpod
List<Symptom> filteredSymptoms(Ref ref) {
  final all = ref.watch(symptomsProvider).asData?.value ?? const [];
  final filter = ref.watch(symptomsFilterProvider);
  final sort = ref.watch(symptomsSortOrderProvider);
  final types = ref.watch(typesByIdProvider);
  return applySort(applyFilter(all, filter), sort, types);
}

/// Symptoms feeding the charts (date/type filtered, unsorted).
@riverpod
List<Symptom> chartSymptoms(Ref ref) {
  final all = ref.watch(symptomsProvider).asData?.value ?? const [];
  final filter = ref.watch(chartsFilterProvider);
  return applyFilter(all, filter);
}

/// Symptoms logged today, newest first.
@riverpod
List<Symptom> todaySymptoms(Ref ref) {
  final all = ref.watch(symptomsProvider).asData?.value ?? const [];
  return symptomsToday(all, DateTime.now());
}
