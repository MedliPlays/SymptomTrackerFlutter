// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SymptomType _$SymptomTypeFromJson(Map<String, dynamic> json) => _SymptomType(
  id: json['id'] as String,
  name: json['name'] as String,
  hasSeverity: json['hasSeverity'] as bool? ?? true,
);

Map<String, dynamic> _$SymptomTypeToJson(_SymptomType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hasSeverity': instance.hasSeverity,
    };
