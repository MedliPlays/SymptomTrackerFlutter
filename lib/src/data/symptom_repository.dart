import 'package:sembast/sembast.dart';

import '../models/symptom.dart';
import '../models/symptom_type.dart';

/// Local persistence for symptom types and instances.
///
/// Records are stored as their JSON maps, keyed by id. `DateTime` values are
/// serialised to ISO-8601 strings by the models' `toJson`, which sembast
/// stores natively.
class SymptomRepository {
  SymptomRepository(this._db);

  final Database _db;

  final _typeStore = stringMapStoreFactory.store('symptom_types');
  final _symptomStore = stringMapStoreFactory.store('symptoms');
  final _metaStore = StoreRef<String, Object?>('meta');

  static const _onboardedKey = 'hasCompletedOnboarding';

  // ---- App meta -------------------------------------------------------------

  Future<bool> hasCompletedOnboarding() async =>
      (await _metaStore.record(_onboardedKey).get(_db)) as bool? ?? false;

  Future<void> setOnboardingComplete() =>
      _metaStore.record(_onboardedKey).put(_db, true);

  // ---- Reactive reads -------------------------------------------------------

  Stream<List<SymptomType>> watchTypes() => _typeStore
      .query()
      .onSnapshots(_db)
      .map((records) => records
          .map((r) => SymptomType.fromJson(Map<String, dynamic>.from(r.value)))
          .toList());

  Stream<List<Symptom>> watchSymptoms() => _symptomStore
      .query()
      .onSnapshots(_db)
      .map((records) => records
          .map((r) => Symptom.fromJson(Map<String, dynamic>.from(r.value)))
          .toList());

  // ---- One-shot reads -------------------------------------------------------

  Future<List<SymptomType>> allTypes() async {
    final records = await _typeStore.find(_db);
    return records
        .map((r) => SymptomType.fromJson(Map<String, dynamic>.from(r.value)))
        .toList();
  }

  Future<List<Symptom>> allSymptoms() async {
    final records = await _symptomStore.find(_db);
    return records
        .map((r) => Symptom.fromJson(Map<String, dynamic>.from(r.value)))
        .toList();
  }

  // ---- Writes ---------------------------------------------------------------

  Future<void> upsertType(SymptomType type) =>
      _typeStore.record(type.id).put(_db, type.toJson());

  Future<void> upsertSymptom(Symptom symptom) =>
      _symptomStore.record(symptom.id).put(_db, symptom.toJson());

  /// Deletes a type and, cascade-style, every symptom instance of that type
  /// (matching the original app's delete rule).
  Future<void> deleteType(String typeId) async {
    await _db.transaction((txn) async {
      await _typeStore.record(typeId).delete(txn);
      await _symptomStore.delete(
        txn,
        finder: Finder(filter: Filter.equals('typeId', typeId)),
      );
    });
  }

  Future<void> deleteSymptom(String symptomId) =>
      _symptomStore.record(symptomId).delete(_db);

  Future<void> deleteAll() async {
    await _db.transaction((txn) async {
      await _symptomStore.delete(txn);
      await _typeStore.delete(txn);
    });
  }

  /// Wipes all data and replaces it with the given records (used by import).
  Future<void> replaceAll({
    required List<SymptomType> types,
    required List<Symptom> symptoms,
  }) async {
    await _db.transaction((txn) async {
      await _symptomStore.delete(txn);
      await _typeStore.delete(txn);
      for (final t in types) {
        await _typeStore.record(t.id).put(txn, t.toJson());
      }
      for (final s in symptoms) {
        await _symptomStore.record(s.id).put(txn, s.toJson());
      }
    });
  }
}
