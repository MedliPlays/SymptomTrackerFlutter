// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The opened sembast database. Overridden with the real instance in `main`
/// once [openAppDatabase] has completed.

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

/// The opened sembast database. Overridden with the real instance in `main`
/// once [openAppDatabase] has completed.

final class DatabaseProvider
    extends $FunctionalProvider<Database, Database, Database>
    with $Provider<Database> {
  /// The opened sembast database. Overridden with the real instance in `main`
  /// once [openAppDatabase] has completed.
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<Database> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Database create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Database value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Database>(value),
    );
  }
}

String _$databaseHash() => r'3168f7280f87b5c8856caffc28a306509990c212';

@ProviderFor(symptomRepository)
final symptomRepositoryProvider = SymptomRepositoryProvider._();

final class SymptomRepositoryProvider
    extends
        $FunctionalProvider<
          SymptomRepository,
          SymptomRepository,
          SymptomRepository
        >
    with $Provider<SymptomRepository> {
  SymptomRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomRepositoryHash();

  @$internal
  @override
  $ProviderElement<SymptomRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SymptomRepository create(Ref ref) {
    return symptomRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomRepository>(value),
    );
  }
}

String _$symptomRepositoryHash() => r'7986dbdc9127a69d1992a44359145d384c8fbd7f';

@ProviderFor(backupService)
final backupServiceProvider = BackupServiceProvider._();

final class BackupServiceProvider
    extends $FunctionalProvider<BackupService, BackupService, BackupService>
    with $Provider<BackupService> {
  BackupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupServiceHash();

  @$internal
  @override
  $ProviderElement<BackupService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupService create(Ref ref) {
    return backupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupService>(value),
    );
  }
}

String _$backupServiceHash() => r'af9369296d3c76231c1cda32059276cdf5e4f32e';

/// Whether the user has completed (or skipped) first-launch onboarding.

@ProviderFor(onboardingCompleted)
final onboardingCompletedProvider = OnboardingCompletedProvider._();

/// Whether the user has completed (or skipped) first-launch onboarding.

final class OnboardingCompletedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Whether the user has completed (or skipped) first-launch onboarding.
  OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return onboardingCompleted(ref);
  }
}

String _$onboardingCompletedHash() =>
    r'853054d00c1f3f9c1127dc1129b1d3d8684449c5';

@ProviderFor(symptomTypes)
final symptomTypesProvider = SymptomTypesProvider._();

final class SymptomTypesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SymptomType>>,
          List<SymptomType>,
          Stream<List<SymptomType>>
        >
    with
        $FutureModifier<List<SymptomType>>,
        $StreamProvider<List<SymptomType>> {
  SymptomTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomTypesHash();

  @$internal
  @override
  $StreamProviderElement<List<SymptomType>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SymptomType>> create(Ref ref) {
    return symptomTypes(ref);
  }
}

String _$symptomTypesHash() => r'cb98ec4a9a0729d75ce0aea634ab7e942be3efbd';

@ProviderFor(symptoms)
final symptomsProvider = SymptomsProvider._();

final class SymptomsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Symptom>>,
          List<Symptom>,
          Stream<List<Symptom>>
        >
    with $FutureModifier<List<Symptom>>, $StreamProvider<List<Symptom>> {
  SymptomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomsHash();

  @$internal
  @override
  $StreamProviderElement<List<Symptom>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Symptom>> create(Ref ref) {
    return symptoms(ref);
  }
}

String _$symptomsHash() => r'4f6ff8f7449b46c631c0571f3f0612fc0ff7dcb2';

/// Types keyed by id, for quick lookup when rendering/sorting.

@ProviderFor(typesById)
final typesByIdProvider = TypesByIdProvider._();

/// Types keyed by id, for quick lookup when rendering/sorting.

final class TypesByIdProvider
    extends
        $FunctionalProvider<
          Map<String, SymptomType>,
          Map<String, SymptomType>,
          Map<String, SymptomType>
        >
    with $Provider<Map<String, SymptomType>> {
  /// Types keyed by id, for quick lookup when rendering/sorting.
  TypesByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typesByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typesByIdHash();

  @$internal
  @override
  $ProviderElement<Map<String, SymptomType>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, SymptomType> create(Ref ref) {
    return typesById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, SymptomType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, SymptomType>>(value),
    );
  }
}

String _$typesByIdHash() => r'd7137f845c63ea02549ded830426f2c46bfefe5b';

/// Types sorted by name (A–Z) for pickers and the Types list.

@ProviderFor(sortedTypes)
final sortedTypesProvider = SortedTypesProvider._();

/// Types sorted by name (A–Z) for pickers and the Types list.

final class SortedTypesProvider
    extends
        $FunctionalProvider<
          List<SymptomType>,
          List<SymptomType>,
          List<SymptomType>
        >
    with $Provider<List<SymptomType>> {
  /// Types sorted by name (A–Z) for pickers and the Types list.
  SortedTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedTypesHash();

  @$internal
  @override
  $ProviderElement<List<SymptomType>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<SymptomType> create(Ref ref) {
    return sortedTypes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SymptomType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SymptomType>>(value),
    );
  }
}

String _$sortedTypesHash() => r'33031d97d16b711bd9dae1900b5d9ac5559e8ca6';

/// Filter for the "All Symptoms" list. Defaults to no date filter (all dates).

@ProviderFor(SymptomsFilter)
final symptomsFilterProvider = SymptomsFilterProvider._();

/// Filter for the "All Symptoms" list. Defaults to no date filter (all dates).
final class SymptomsFilterProvider
    extends $NotifierProvider<SymptomsFilter, SymptomFilter> {
  /// Filter for the "All Symptoms" list. Defaults to no date filter (all dates).
  SymptomsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomsFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomsFilterHash();

  @$internal
  @override
  SymptomsFilter create() => SymptomsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomFilter>(value),
    );
  }
}

String _$symptomsFilterHash() => r'9d58b8b9914c200a3dce0505467ebeab2213cf88';

/// Filter for the "All Symptoms" list. Defaults to no date filter (all dates).

abstract class _$SymptomsFilter extends $Notifier<SymptomFilter> {
  SymptomFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SymptomFilter, SymptomFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SymptomFilter, SymptomFilter>,
              SymptomFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Filter for the Charts screen. Defaults to a rolling 10-day window, matching
/// the original app.

@ProviderFor(ChartsFilter)
final chartsFilterProvider = ChartsFilterProvider._();

/// Filter for the Charts screen. Defaults to a rolling 10-day window, matching
/// the original app.
final class ChartsFilterProvider
    extends $NotifierProvider<ChartsFilter, SymptomFilter> {
  /// Filter for the Charts screen. Defaults to a rolling 10-day window, matching
  /// the original app.
  ChartsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chartsFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chartsFilterHash();

  @$internal
  @override
  ChartsFilter create() => ChartsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomFilter>(value),
    );
  }
}

String _$chartsFilterHash() => r'c36a8cc884871837608dc22502ab981125f37537';

/// Filter for the Charts screen. Defaults to a rolling 10-day window, matching
/// the original app.

abstract class _$ChartsFilter extends $Notifier<SymptomFilter> {
  SymptomFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SymptomFilter, SymptomFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SymptomFilter, SymptomFilter>,
              SymptomFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SymptomsSortOrder)
final symptomsSortOrderProvider = SymptomsSortOrderProvider._();

final class SymptomsSortOrderProvider
    extends $NotifierProvider<SymptomsSortOrder, SymptomSort> {
  SymptomsSortOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomsSortOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomsSortOrderHash();

  @$internal
  @override
  SymptomsSortOrder create() => SymptomsSortOrder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomSort>(value),
    );
  }
}

String _$symptomsSortOrderHash() => r'1ce72550021b13cfa710f4dc2e9e5a27a6385fa9';

abstract class _$SymptomsSortOrder extends $Notifier<SymptomSort> {
  SymptomSort build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SymptomSort, SymptomSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SymptomSort, SymptomSort>,
              SymptomSort,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(TypesSeverityFilter)
final typesSeverityFilterProvider = TypesSeverityFilterProvider._();

final class TypesSeverityFilterProvider
    extends $NotifierProvider<TypesSeverityFilter, TypeSeverityFilter> {
  TypesSeverityFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typesSeverityFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typesSeverityFilterHash();

  @$internal
  @override
  TypesSeverityFilter create() => TypesSeverityFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TypeSeverityFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TypeSeverityFilter>(value),
    );
  }
}

String _$typesSeverityFilterHash() =>
    r'f0059dd9027caad30aa4c5800a73bf8980922af1';

abstract class _$TypesSeverityFilter extends $Notifier<TypeSeverityFilter> {
  TypeSeverityFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TypeSeverityFilter, TypeSeverityFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TypeSeverityFilter, TypeSeverityFilter>,
              TypeSeverityFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(TypesSortOrder)
final typesSortOrderProvider = TypesSortOrderProvider._();

final class TypesSortOrderProvider
    extends $NotifierProvider<TypesSortOrder, TypeSort> {
  TypesSortOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typesSortOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typesSortOrderHash();

  @$internal
  @override
  TypesSortOrder create() => TypesSortOrder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TypeSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TypeSort>(value),
    );
  }
}

String _$typesSortOrderHash() => r'66fc943468b8b92ac65711cef4255f814e29c5c6';

abstract class _$TypesSortOrder extends $Notifier<TypeSort> {
  TypeSort build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TypeSort, TypeSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TypeSort, TypeSort>,
              TypeSort,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Types after applying the Types-list filter + sort.

@ProviderFor(displayedTypes)
final displayedTypesProvider = DisplayedTypesProvider._();

/// Types after applying the Types-list filter + sort.

final class DisplayedTypesProvider
    extends
        $FunctionalProvider<
          List<SymptomType>,
          List<SymptomType>,
          List<SymptomType>
        >
    with $Provider<List<SymptomType>> {
  /// Types after applying the Types-list filter + sort.
  DisplayedTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedTypesHash();

  @$internal
  @override
  $ProviderElement<List<SymptomType>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<SymptomType> create(Ref ref) {
    return displayedTypes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SymptomType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SymptomType>>(value),
    );
  }
}

String _$displayedTypesHash() => r'525a40072e9cd6e46f77ea53143d3eb2b9289f05';

/// Symptoms after applying the list filter + sort order.

@ProviderFor(filteredSymptoms)
final filteredSymptomsProvider = FilteredSymptomsProvider._();

/// Symptoms after applying the list filter + sort order.

final class FilteredSymptomsProvider
    extends $FunctionalProvider<List<Symptom>, List<Symptom>, List<Symptom>>
    with $Provider<List<Symptom>> {
  /// Symptoms after applying the list filter + sort order.
  FilteredSymptomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredSymptomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredSymptomsHash();

  @$internal
  @override
  $ProviderElement<List<Symptom>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Symptom> create(Ref ref) {
    return filteredSymptoms(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Symptom> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Symptom>>(value),
    );
  }
}

String _$filteredSymptomsHash() => r'c82b9f6ca1fea3544b8259050b3d7dc7b11917d3';

/// Symptoms feeding the charts (date/type filtered, unsorted).

@ProviderFor(chartSymptoms)
final chartSymptomsProvider = ChartSymptomsProvider._();

/// Symptoms feeding the charts (date/type filtered, unsorted).

final class ChartSymptomsProvider
    extends $FunctionalProvider<List<Symptom>, List<Symptom>, List<Symptom>>
    with $Provider<List<Symptom>> {
  /// Symptoms feeding the charts (date/type filtered, unsorted).
  ChartSymptomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chartSymptomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chartSymptomsHash();

  @$internal
  @override
  $ProviderElement<List<Symptom>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Symptom> create(Ref ref) {
    return chartSymptoms(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Symptom> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Symptom>>(value),
    );
  }
}

String _$chartSymptomsHash() => r'eeaaf289dc49bcb4f051ca1ccf5d5a8a4bce44c9';

/// Symptoms logged today, newest first.

@ProviderFor(todaySymptoms)
final todaySymptomsProvider = TodaySymptomsProvider._();

/// Symptoms logged today, newest first.

final class TodaySymptomsProvider
    extends $FunctionalProvider<List<Symptom>, List<Symptom>, List<Symptom>>
    with $Provider<List<Symptom>> {
  /// Symptoms logged today, newest first.
  TodaySymptomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaySymptomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaySymptomsHash();

  @$internal
  @override
  $ProviderElement<List<Symptom>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Symptom> create(Ref ref) {
    return todaySymptoms(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Symptom> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Symptom>>(value),
    );
  }
}

String _$todaySymptomsHash() => r'da9fdaa2306e53896a5cf24f687db35cc0633e56';
