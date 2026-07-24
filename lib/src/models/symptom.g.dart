// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Symptom _$SymptomFromJson(Map<String, dynamic> json) => _Symptom(
  id: json['id'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  typeId: json['typeId'] as String,
  severity: (json['severity'] as num?)?.toDouble() ?? 0,
  notes: json['notes'] as String? ?? '',
);

Map<String, dynamic> _$SymptomToJson(_Symptom instance) => <String, dynamic>{
  'id': instance.id,
  'timestamp': instance.timestamp.toIso8601String(),
  'typeId': instance.typeId,
  'severity': instance.severity,
  'notes': instance.notes,
};
