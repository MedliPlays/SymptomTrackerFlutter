import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../models/export_file.dart';
import '../models/symptom.dart';
import '../models/symptom_type.dart';
import 'symptom_repository.dart';

const _uuid = Uuid();

/// Raised when an import file can't be used.
class ImportException implements Exception {
  ImportException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Handles backup (export) and restore (import) of all data.
///
/// The on-disk format is intentionally identical to the original iOS app's
/// export so existing user backups remain importable:
/// `{ schemaVersion, exportedAt, symptomTypes[], symptoms[] }`.
class BackupService {
  BackupService(this._repository);

  final SymptomRepository _repository;

  /// Serialises all current data to pretty-printed JSON bytes.
  Future<List<int>> exportToBytes() async {
    final types = await _repository.allTypes();
    final symptoms = await _repository.allSymptoms();

    final export = ExportFile(
      schemaVersion: currentSchemaVersion,
      exportedAt: DateTime.now().toUtc(),
      symptomTypes: types
          .map((t) => SymptomTypeDto(
                id: t.id,
                name: t.name,
                hasSeverity: t.hasSeverity,
              ))
          .toList(),
      symptoms: symptoms
          .map((s) => SymptomDto(
                timestamp: s.timestamp.toUtc(),
                typeId: s.typeId,
                severity: s.severity,
                notes: s.notes,
              ))
          .toList(),
    );

    const encoder = JsonEncoder.withIndent('  ');
    return utf8.encode(encoder.convert(export.toJson()));
  }

  /// Suggested filename for exports (mirrors the original "SymptomBackup").
  String get suggestedFileName => 'SymptomBackup.json';

  /// Parses [bytes] and replaces ALL existing data.
  ///
  /// Compatible with the original iOS export: symptom instances have no id of
  /// their own (fresh ids are generated) and any instance whose `typeID` is
  /// null or references a missing type is skipped — matching the old importer.
  Future<int> importFromBytes(List<int> bytes) async {
    final ExportFile file;
    try {
      final decoded = json.decode(utf8.decode(bytes)) as Map<String, dynamic>;
      file = ExportFile.fromJson(decoded);
    } catch (e) {
      throw ImportException('This file isn\'t a valid Eir backup.');
    }

    if (file.schemaVersion != currentSchemaVersion) {
      throw ImportException(
          'Unsupported backup version (${file.schemaVersion}).');
    }

    final types = file.symptomTypes
        .map((d) => SymptomType(
              id: d.id,
              name: d.name,
              hasSeverity: d.hasSeverity,
            ))
        .toList();
    final typeIds = {for (final t in types) t.id};

    final symptoms = <Symptom>[];
    for (final d in file.symptoms) {
      final typeId = d.typeId;
      if (typeId == null || !typeIds.contains(typeId)) continue;
      symptoms.add(Symptom(
        id: _uuid.v4(),
        timestamp: d.timestamp,
        typeId: typeId,
        severity: d.severity,
        notes: d.notes,
      ));
    }

    await _repository.replaceAll(types: types, symptoms: symptoms);
    return symptoms.length;
  }
}
