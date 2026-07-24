import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom.freezed.dart';
part 'symptom.g.dart';

/// A single logged instance of a symptom at a point in time.
///
/// [typeId] references a [SymptomType.id] and is mandatory: every instance
/// belongs to a type. (The original SwiftData model made this optional only to
/// satisfy CloudKit sync; that quirk is dropped here. Deleting a type
/// cascade-deletes its instances, so the reference never dangles.) [severity]
/// is only meaningful when the referenced type has severity enabled; otherwise
/// it is stored as 0.
@freezed
abstract class Symptom with _$Symptom {
  const factory Symptom({
    required String id,
    required DateTime timestamp,
    required String typeId,
    @Default(0) double severity,
    @Default('') String notes,
  }) = _Symptom;

  factory Symptom.fromJson(Map<String, dynamic> json) =>
      _$SymptomFromJson(json);
}
