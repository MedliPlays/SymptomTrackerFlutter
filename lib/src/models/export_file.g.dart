// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SymptomTypeDto _$SymptomTypeDtoFromJson(Map<String, dynamic> json) =>
    _SymptomTypeDto(
      id: json['id'] as String,
      name: json['name'] as String,
      hasSeverity: json['hasSeverity'] as bool,
    );

Map<String, dynamic> _$SymptomTypeDtoToJson(_SymptomTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hasSeverity': instance.hasSeverity,
    };

_SymptomDto _$SymptomDtoFromJson(Map<String, dynamic> json) => _SymptomDto(
  timestamp: DateTime.parse(json['timestamp'] as String),
  typeId: json['typeID'] as String?,
  severity: (json['severity'] as num).toDouble(),
  notes: json['notes'] as String,
);

Map<String, dynamic> _$SymptomDtoToJson(_SymptomDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'typeID': instance.typeId,
      'severity': instance.severity,
      'notes': instance.notes,
    };

_ExportFile _$ExportFileFromJson(Map<String, dynamic> json) => _ExportFile(
  schemaVersion: (json['schemaVersion'] as num).toInt(),
  exportedAt: DateTime.parse(json['exportedAt'] as String),
  symptomTypes: (json['symptomTypes'] as List<dynamic>)
      .map((e) => SymptomTypeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  symptoms: (json['symptoms'] as List<dynamic>)
      .map((e) => SymptomDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExportFileToJson(_ExportFile instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'exportedAt': instance.exportedAt.toIso8601String(),
      'symptomTypes': instance.symptomTypes.map((e) => e.toJson()).toList(),
      'symptoms': instance.symptoms.map((e) => e.toJson()).toList(),
    };
