import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:symptom_tracker/src/data/backup_service.dart';
import 'package:symptom_tracker/src/data/symptom_repository.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';

Future<SymptomRepository> newRepo() async =>
    SymptomRepository(await newDatabaseFactoryMemory().openDatabase('t.db'));

void main() {
  test('export then import round-trips types and symptoms', () async {
    final source = await newRepo();
    await source.upsertType(const SymptomType(id: 'A', name: 'Headache'));
    await source
        .upsertType(const SymptomType(id: 'B', name: 'Period', hasSeverity: false));
    await source.upsertSymptom(Symptom(
      id: 's1',
      typeId: 'A',
      timestamp: DateTime.utc(2026, 1, 5, 9, 30),
      severity: 7,
      notes: 'throb',
    ));
    await source.upsertSymptom(Symptom(
      id: 's2',
      typeId: 'B',
      timestamp: DateTime.utc(2026, 1, 6, 8),
    ));

    final bytes = await BackupService(source).exportToBytes();

    final target = await newRepo();
    final imported = await BackupService(target).importFromBytes(bytes);

    expect(imported, 2);
    final types = await target.allTypes();
    expect(types.map((t) => t.id).toSet(), {'A', 'B'});

    final symptoms = await target.allSymptoms()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    expect(symptoms, hasLength(2));
    expect(symptoms.first.typeId, 'A');
    expect(symptoms.first.severity, 7);
    expect(symptoms.first.notes, 'throb');
    expect(symptoms.first.timestamp.toUtc(), DateTime.utc(2026, 1, 5, 9, 30));
  });

  test('import assigns fresh symptom ids (originals have none)', () async {
    final source = await newRepo();
    await source.upsertType(const SymptomType(id: 'A', name: 'A'));
    await source.upsertSymptom(Symptom(
        id: 'original-id', typeId: 'A', timestamp: DateTime.utc(2026, 1, 1)));

    final bytes = await BackupService(source).exportToBytes();
    final target = await newRepo();
    await BackupService(target).importFromBytes(bytes);

    // The export format carries no symptom id, so a new one is generated.
    expect((await target.allSymptoms()).single.id, isNot('original-id'));
  });

  test('import replaces all existing data', () async {
    final source = await newRepo();
    await source.upsertType(const SymptomType(id: 'NEW', name: 'New'));
    final bytes = await BackupService(source).exportToBytes();

    final target = await newRepo();
    await target.upsertType(const SymptomType(id: 'OLD', name: 'Old'));
    await target.upsertSymptom(Symptom(
        id: 'x', typeId: 'OLD', timestamp: DateTime.utc(2026, 1, 1)));

    await BackupService(target).importFromBytes(bytes);
    expect((await target.allTypes()).map((t) => t.id), ['NEW']);
    expect(await target.allSymptoms(), isEmpty);
  });

  test('skips symptoms whose type is null or missing', () async {
    const iosExport = '''
{
  "schemaVersion": 1,
  "exportedAt": "2026-01-29T12:00:00Z",
  "symptomTypes": [
    { "id": "A", "name": "Headache", "hasSeverity": true }
  ],
  "symptoms": [
    { "timestamp": "2026-01-28T09:30:00Z", "typeID": "A", "severity": 7, "notes": "" },
    { "timestamp": "2026-01-27T09:30:00Z", "typeID": null, "severity": 3, "notes": "" },
    { "timestamp": "2026-01-26T09:30:00Z", "typeID": "GONE", "severity": 3, "notes": "" }
  ]
}
''';
    final repo = await newRepo();
    final count =
        await BackupService(repo).importFromBytes(utf8.encode(iosExport));
    expect(count, 1); // only the entry referencing type A survives
    expect((await repo.allSymptoms()).single.typeId, 'A');
  });

  test('rejects unsupported schema version', () async {
    const future = '{"schemaVersion": 99, "exportedAt": "2026-01-01T00:00:00Z", '
        '"symptomTypes": [], "symptoms": []}';
    final repo = await newRepo();
    expect(
      () => BackupService(repo).importFromBytes(utf8.encode(future)),
      throwsA(isA<ImportException>()),
    );
  });

  test('rejects malformed files', () async {
    final repo = await newRepo();
    expect(
      () => BackupService(repo).importFromBytes(utf8.encode('not json')),
      throwsA(isA<ImportException>()),
    );
  });

  test('a failed import does not wipe existing data', () async {
    final repo = await newRepo();
    await repo.upsertType(const SymptomType(id: 'A', name: 'Keep me'));
    try {
      await BackupService(repo).importFromBytes(utf8.encode('garbage'));
    } on ImportException {
      // expected
    }
    expect((await repo.allTypes()).single.name, 'Keep me');
  });
}
