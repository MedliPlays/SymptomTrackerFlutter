import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_type.freezed.dart';
part 'symptom_type.g.dart';

/// A kind of symptom the user tracks (e.g. "Headache").
///
/// [hasSeverity] controls whether instances of this type record a severity
/// value (and thus show a slider when logging).
@freezed
abstract class SymptomType with _$SymptomType {
  const factory SymptomType({
    required String id,
    required String name,
    @Default(true) bool hasSeverity,
  }) = _SymptomType;

  factory SymptomType.fromJson(Map<String, dynamic> json) =>
      _$SymptomTypeFromJson(json);
}
