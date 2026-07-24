import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:symptom_tracker/src/data/symptom_repository.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';

Future<SymptomRepository> newRepo() async {
  // Isolated in-memory database per call.
  final db = await newDatabaseFactoryMemory().openDatabase('test.db');
  return SymptomRepository(db);
}

Symptom sym(String id, String typeId, {double severity = 0, String notes = ''}) =>
    Symptom(
      id: id,
      typeId: typeId,
      timestamp: DateTime(2026, 1, 1, 9),
      severity: severity,
      notes: notes,
    );

void main() {
  test('upsert and read types & symptoms', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'Headache'));
    await repo.upsertSymptom(sym('s1', 'A', severity: 5, notes: 'ow'));

    final types = await repo.allTypes();
    final symptoms = await repo.allSymptoms();
    expect(types.single.name, 'Headache');
    expect(symptoms.single.severity, 5);
    expect(symptoms.single.notes, 'ow');
    // Round-trips DateTime correctly.
    expect(symptoms.single.timestamp, DateTime(2026, 1, 1, 9));
  });

  test('upsert with an existing id updates in place', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'Headache'));
    await repo.upsertType(const SymptomType(id: 'A', name: 'Migraine'));
    final types = await repo.allTypes();
    expect(types, hasLength(1));
    expect(types.single.name, 'Migraine');
  });

  test('deleteType cascade-deletes its symptoms only', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'A'));
    await repo.upsertType(const SymptomType(id: 'B', name: 'B'));
    await repo.upsertSymptom(sym('a1', 'A'));
    await repo.upsertSymptom(sym('a2', 'A'));
    await repo.upsertSymptom(sym('b1', 'B'));

    await repo.deleteType('A');

    expect((await repo.allTypes()).map((t) => t.id), ['B']);
    expect((await repo.allSymptoms()).map((s) => s.id), ['b1']);
  });

  test('deleteSymptom removes one entry', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'A'));
    await repo.upsertSymptom(sym('a1', 'A'));
    await repo.upsertSymptom(sym('a2', 'A'));
    await repo.deleteSymptom('a1');
    expect((await repo.allSymptoms()).map((s) => s.id), ['a2']);
  });

  test('deleteAll wipes everything', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'A'));
    await repo.upsertSymptom(sym('a1', 'A'));
    await repo.deleteAll();
    expect(await repo.allTypes(), isEmpty);
    expect(await repo.allSymptoms(), isEmpty);
  });

  test('replaceAll swaps in a fresh dataset', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'OLD', name: 'Old'));
    await repo.upsertSymptom(sym('old1', 'OLD'));

    await repo.replaceAll(
      types: [const SymptomType(id: 'NEW', name: 'New')],
      symptoms: [sym('new1', 'NEW')],
    );

    expect((await repo.allTypes()).map((t) => t.id), ['NEW']);
    expect((await repo.allSymptoms()).map((s) => s.id), ['new1']);
  });

  test('watchTypes emits on change', () async {
    final repo = await newRepo();
    final future = repo.watchTypes().firstWhere((types) => types.isNotEmpty);
    await repo.upsertType(const SymptomType(id: 'A', name: 'Headache'));
    final emitted = await future;
    expect(emitted.single.name, 'Headache');
  });

  test('onboarding flag defaults false and can be set', () async {
    final repo = await newRepo();
    expect(await repo.hasCompletedOnboarding(), isFalse);
    await repo.setOnboardingComplete();
    expect(await repo.hasCompletedOnboarding(), isTrue);
  });
}
