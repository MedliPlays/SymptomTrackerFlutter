import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_file.freezed.dart';
part 'export_file.g.dart';

/// Backup/restore file format.
///
/// This MUST stay byte-compatible with the original iOS (SwiftData) app's
/// export so existing user backups can be imported into this rewrite:
///   {
///     "schemaVersion": 1,
///     "exportedAt": "ISO8601 string",
///     "symptomTypes": [{ "id", "name", "hasSeverity" }],
///     "symptoms":     [{ "timestamp", "typeID", "severity", "notes" }]
///   }
/// Note the `typeID` key casing and that symptom instances carry no id of
/// their own — relationships are keyed on the type id.
const int currentSchemaVersion = 1;

@freezed
abstract class SymptomTypeDto with _$SymptomTypeDto {
  const factory SymptomTypeDto({
    required String id,
    required String name,
    required bool hasSeverity,
  }) = _SymptomTypeDto;

  factory SymptomTypeDto.fromJson(Map<String, dynamic> json) =>
      _$SymptomTypeDtoFromJson(json);
}

@freezed
abstract class SymptomDto with _$SymptomDto {
  const factory SymptomDto({
    required DateTime timestamp,
    @JsonKey(name: 'typeID') String? typeId,
    required double severity,
    required String notes,
  }) = _SymptomDto;

  factory SymptomDto.fromJson(Map<String, dynamic> json) =>
      _$SymptomDtoFromJson(json);
}

@freezed
abstract class ExportFile with _$ExportFile {
  const factory ExportFile({
    required int schemaVersion,
    required DateTime exportedAt,
    required List<SymptomTypeDto> symptomTypes,
    required List<SymptomDto> symptoms,
  }) = _ExportFile;

  factory ExportFile.fromJson(Map<String, dynamic> json) =>
      _$ExportFileFromJson(json);
}
