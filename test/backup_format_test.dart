import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/src/models/export_file.dart';

/// A backup exported by the ORIGINAL iOS (SwiftData) app. This is the exact
/// shape existing TestFlight users' backups have, so the Flutter importer must
/// parse it: uppercase UUIDs, `typeID` key casing, ISO-8601 `Z` timestamps,
/// sorted/pretty keys, and a symptom whose `typeID` is null.
const _iosExport = '''
{
  "exportedAt" : "2026-01-29T12:00:00Z",
  "schemaVersion" : 1,
  "symptomTypes" : [
    {
      "hasSeverity" : true,
      "id" : "E621E1F8-C36C-495A-93FC-0C247A3E6E5F",
      "name" : "Headache"
    },
    {
      "hasSeverity" : false,
      "id" : "11111111-2222-3333-4444-555555555555",
      "name" : "Start of menstruation"
    }
  ],
  "symptoms" : [
    {
      "notes" : "throbbing",
      "severity" : 7,
      "timestamp" : "2026-01-28T09:30:00Z",
      "typeID" : "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
    },
    {
      "notes" : "",
      "severity" : 0,
      "timestamp" : "2026-01-27T08:00:00Z",
      "typeID" : "11111111-2222-3333-4444-555555555555"
    },
    {
      "notes" : "orphaned - type was deleted",
      "severity" : 3,
      "timestamp" : "2026-01-26T08:00:00Z",
      "typeID" : null
    }
  ]
}
''';

void main() {
  group('iOS export compatibility', () {
    test('parses the original app export format', () {
      final file = ExportFile.fromJson(
          json.decode(_iosExport) as Map<String, dynamic>);

      expect(file.schemaVersion, 1);
      expect(file.exportedAt.toUtc(), DateTime.utc(2026, 1, 29, 12));
      expect(file.symptomTypes, hasLength(2));
      expect(file.symptomTypes.first.name, 'Headache');
      expect(file.symptomTypes.first.hasSeverity, isTrue);

      expect(file.symptoms, hasLength(3));
      // typeID key maps to typeId, casing preserved.
      expect(file.symptoms.first.typeId,
          'E621E1F8-C36C-495A-93FC-0C247A3E6E5F');
      expect(file.symptoms.first.severity, 7);
      expect(file.symptoms.first.notes, 'throbbing');
      // Null type instance survives parsing (importer skips it later).
      expect(file.symptoms.last.typeId, isNull);
    });

    test('re-exports with the same key names', () {
      final file = ExportFile.fromJson(
          json.decode(_iosExport) as Map<String, dynamic>);
      final roundTripped = file.toJson();

      expect(roundTripped.keys,
          containsAll(['schemaVersion', 'exportedAt', 'symptomTypes', 'symptoms']));
      final firstSymptom =
          (roundTripped['symptoms'] as List).first as Map<String, dynamic>;
      // Must emit `typeID` (not `typeId`) to stay compatible.
      expect(firstSymptom.containsKey('typeID'), isTrue);
      expect(firstSymptom.containsKey('typeId'), isFalse);

      final firstType =
          (roundTripped['symptomTypes'] as List).first as Map<String, dynamic>;
      expect(firstType.keys, containsAll(['id', 'name', 'hasSeverity']));
    });
  });
}
