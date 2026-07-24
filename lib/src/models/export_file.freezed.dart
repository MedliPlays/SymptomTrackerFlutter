// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymptomTypeDto {

 String get id; String get name; bool get hasSeverity;
/// Create a copy of SymptomTypeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomTypeDtoCopyWith<SymptomTypeDto> get copyWith => _$SymptomTypeDtoCopyWithImpl<SymptomTypeDto>(this as SymptomTypeDto, _$identity);

  /// Serializes this SymptomTypeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomTypeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasSeverity, hasSeverity) || other.hasSeverity == hasSeverity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hasSeverity);

@override
String toString() {
  return 'SymptomTypeDto(id: $id, name: $name, hasSeverity: $hasSeverity)';
}


}

/// @nodoc
abstract mixin class $SymptomTypeDtoCopyWith<$Res>  {
  factory $SymptomTypeDtoCopyWith(SymptomTypeDto value, $Res Function(SymptomTypeDto) _then) = _$SymptomTypeDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool hasSeverity
});




}
/// @nodoc
class _$SymptomTypeDtoCopyWithImpl<$Res>
    implements $SymptomTypeDtoCopyWith<$Res> {
  _$SymptomTypeDtoCopyWithImpl(this._self, this._then);

  final SymptomTypeDto _self;
  final $Res Function(SymptomTypeDto) _then;

/// Create a copy of SymptomTypeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? hasSeverity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasSeverity: null == hasSeverity ? _self.hasSeverity : hasSeverity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SymptomTypeDto].
extension SymptomTypeDtoPatterns on SymptomTypeDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomTypeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomTypeDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomTypeDto value)  $default,){
final _that = this;
switch (_that) {
case _SymptomTypeDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomTypeDto value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomTypeDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool hasSeverity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomTypeDto() when $default != null:
return $default(_that.id,_that.name,_that.hasSeverity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool hasSeverity)  $default,) {final _that = this;
switch (_that) {
case _SymptomTypeDto():
return $default(_that.id,_that.name,_that.hasSeverity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool hasSeverity)?  $default,) {final _that = this;
switch (_that) {
case _SymptomTypeDto() when $default != null:
return $default(_that.id,_that.name,_that.hasSeverity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SymptomTypeDto implements SymptomTypeDto {
  const _SymptomTypeDto({required this.id, required this.name, required this.hasSeverity});
  factory _SymptomTypeDto.fromJson(Map<String, dynamic> json) => _$SymptomTypeDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool hasSeverity;

/// Create a copy of SymptomTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomTypeDtoCopyWith<_SymptomTypeDto> get copyWith => __$SymptomTypeDtoCopyWithImpl<_SymptomTypeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymptomTypeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomTypeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasSeverity, hasSeverity) || other.hasSeverity == hasSeverity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hasSeverity);

@override
String toString() {
  return 'SymptomTypeDto(id: $id, name: $name, hasSeverity: $hasSeverity)';
}


}

/// @nodoc
abstract mixin class _$SymptomTypeDtoCopyWith<$Res> implements $SymptomTypeDtoCopyWith<$Res> {
  factory _$SymptomTypeDtoCopyWith(_SymptomTypeDto value, $Res Function(_SymptomTypeDto) _then) = __$SymptomTypeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool hasSeverity
});




}
/// @nodoc
class __$SymptomTypeDtoCopyWithImpl<$Res>
    implements _$SymptomTypeDtoCopyWith<$Res> {
  __$SymptomTypeDtoCopyWithImpl(this._self, this._then);

  final _SymptomTypeDto _self;
  final $Res Function(_SymptomTypeDto) _then;

/// Create a copy of SymptomTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? hasSeverity = null,}) {
  return _then(_SymptomTypeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasSeverity: null == hasSeverity ? _self.hasSeverity : hasSeverity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SymptomDto {

 DateTime get timestamp;@JsonKey(name: 'typeID') String? get typeId; double get severity; String get notes;
/// Create a copy of SymptomDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomDtoCopyWith<SymptomDto> get copyWith => _$SymptomDtoCopyWithImpl<SymptomDto>(this as SymptomDto, _$identity);

  /// Serializes this SymptomDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.typeId, typeId) || other.typeId == typeId)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,typeId,severity,notes);

@override
String toString() {
  return 'SymptomDto(timestamp: $timestamp, typeId: $typeId, severity: $severity, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $SymptomDtoCopyWith<$Res>  {
  factory $SymptomDtoCopyWith(SymptomDto value, $Res Function(SymptomDto) _then) = _$SymptomDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@JsonKey(name: 'typeID') String? typeId, double severity, String notes
});




}
/// @nodoc
class _$SymptomDtoCopyWithImpl<$Res>
    implements $SymptomDtoCopyWith<$Res> {
  _$SymptomDtoCopyWithImpl(this._self, this._then);

  final SymptomDto _self;
  final $Res Function(SymptomDto) _then;

/// Create a copy of SymptomDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? typeId = freezed,Object? severity = null,Object? notes = null,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SymptomDto].
extension SymptomDtoPatterns on SymptomDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomDto value)  $default,){
final _that = this;
switch (_that) {
case _SymptomDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomDto value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @JsonKey(name: 'typeID')  String? typeId,  double severity,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomDto() when $default != null:
return $default(_that.timestamp,_that.typeId,_that.severity,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @JsonKey(name: 'typeID')  String? typeId,  double severity,  String notes)  $default,) {final _that = this;
switch (_that) {
case _SymptomDto():
return $default(_that.timestamp,_that.typeId,_that.severity,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @JsonKey(name: 'typeID')  String? typeId,  double severity,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _SymptomDto() when $default != null:
return $default(_that.timestamp,_that.typeId,_that.severity,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SymptomDto implements SymptomDto {
  const _SymptomDto({required this.timestamp, @JsonKey(name: 'typeID') this.typeId, required this.severity, required this.notes});
  factory _SymptomDto.fromJson(Map<String, dynamic> json) => _$SymptomDtoFromJson(json);

@override final  DateTime timestamp;
@override@JsonKey(name: 'typeID') final  String? typeId;
@override final  double severity;
@override final  String notes;

/// Create a copy of SymptomDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomDtoCopyWith<_SymptomDto> get copyWith => __$SymptomDtoCopyWithImpl<_SymptomDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymptomDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.typeId, typeId) || other.typeId == typeId)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,typeId,severity,notes);

@override
String toString() {
  return 'SymptomDto(timestamp: $timestamp, typeId: $typeId, severity: $severity, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$SymptomDtoCopyWith<$Res> implements $SymptomDtoCopyWith<$Res> {
  factory _$SymptomDtoCopyWith(_SymptomDto value, $Res Function(_SymptomDto) _then) = __$SymptomDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@JsonKey(name: 'typeID') String? typeId, double severity, String notes
});




}
/// @nodoc
class __$SymptomDtoCopyWithImpl<$Res>
    implements _$SymptomDtoCopyWith<$Res> {
  __$SymptomDtoCopyWithImpl(this._self, this._then);

  final _SymptomDto _self;
  final $Res Function(_SymptomDto) _then;

/// Create a copy of SymptomDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? typeId = freezed,Object? severity = null,Object? notes = null,}) {
  return _then(_SymptomDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExportFile {

 int get schemaVersion; DateTime get exportedAt; List<SymptomTypeDto> get symptomTypes; List<SymptomDto> get symptoms;
/// Create a copy of ExportFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportFileCopyWith<ExportFile> get copyWith => _$ExportFileCopyWithImpl<ExportFile>(this as ExportFile, _$identity);

  /// Serializes this ExportFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportFile&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other.symptomTypes, symptomTypes)&&const DeepCollectionEquality().equals(other.symptoms, symptoms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,exportedAt,const DeepCollectionEquality().hash(symptomTypes),const DeepCollectionEquality().hash(symptoms));

@override
String toString() {
  return 'ExportFile(schemaVersion: $schemaVersion, exportedAt: $exportedAt, symptomTypes: $symptomTypes, symptoms: $symptoms)';
}


}

/// @nodoc
abstract mixin class $ExportFileCopyWith<$Res>  {
  factory $ExportFileCopyWith(ExportFile value, $Res Function(ExportFile) _then) = _$ExportFileCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, DateTime exportedAt, List<SymptomTypeDto> symptomTypes, List<SymptomDto> symptoms
});




}
/// @nodoc
class _$ExportFileCopyWithImpl<$Res>
    implements $ExportFileCopyWith<$Res> {
  _$ExportFileCopyWithImpl(this._self, this._then);

  final ExportFile _self;
  final $Res Function(ExportFile) _then;

/// Create a copy of ExportFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? exportedAt = null,Object? symptomTypes = null,Object? symptoms = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,symptomTypes: null == symptomTypes ? _self.symptomTypes : symptomTypes // ignore: cast_nullable_to_non_nullable
as List<SymptomTypeDto>,symptoms: null == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<SymptomDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportFile].
extension ExportFilePatterns on ExportFile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportFile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportFile value)  $default,){
final _that = this;
switch (_that) {
case _ExportFile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportFile value)?  $default,){
final _that = this;
switch (_that) {
case _ExportFile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  DateTime exportedAt,  List<SymptomTypeDto> symptomTypes,  List<SymptomDto> symptoms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportFile() when $default != null:
return $default(_that.schemaVersion,_that.exportedAt,_that.symptomTypes,_that.symptoms);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  DateTime exportedAt,  List<SymptomTypeDto> symptomTypes,  List<SymptomDto> symptoms)  $default,) {final _that = this;
switch (_that) {
case _ExportFile():
return $default(_that.schemaVersion,_that.exportedAt,_that.symptomTypes,_that.symptoms);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  DateTime exportedAt,  List<SymptomTypeDto> symptomTypes,  List<SymptomDto> symptoms)?  $default,) {final _that = this;
switch (_that) {
case _ExportFile() when $default != null:
return $default(_that.schemaVersion,_that.exportedAt,_that.symptomTypes,_that.symptoms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExportFile implements ExportFile {
  const _ExportFile({required this.schemaVersion, required this.exportedAt, required final  List<SymptomTypeDto> symptomTypes, required final  List<SymptomDto> symptoms}): _symptomTypes = symptomTypes,_symptoms = symptoms;
  factory _ExportFile.fromJson(Map<String, dynamic> json) => _$ExportFileFromJson(json);

@override final  int schemaVersion;
@override final  DateTime exportedAt;
 final  List<SymptomTypeDto> _symptomTypes;
@override List<SymptomTypeDto> get symptomTypes {
  if (_symptomTypes is EqualUnmodifiableListView) return _symptomTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptomTypes);
}

 final  List<SymptomDto> _symptoms;
@override List<SymptomDto> get symptoms {
  if (_symptoms is EqualUnmodifiableListView) return _symptoms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptoms);
}


/// Create a copy of ExportFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportFileCopyWith<_ExportFile> get copyWith => __$ExportFileCopyWithImpl<_ExportFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportFile&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other._symptomTypes, _symptomTypes)&&const DeepCollectionEquality().equals(other._symptoms, _symptoms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,exportedAt,const DeepCollectionEquality().hash(_symptomTypes),const DeepCollectionEquality().hash(_symptoms));

@override
String toString() {
  return 'ExportFile(schemaVersion: $schemaVersion, exportedAt: $exportedAt, symptomTypes: $symptomTypes, symptoms: $symptoms)';
}


}

/// @nodoc
abstract mixin class _$ExportFileCopyWith<$Res> implements $ExportFileCopyWith<$Res> {
  factory _$ExportFileCopyWith(_ExportFile value, $Res Function(_ExportFile) _then) = __$ExportFileCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, DateTime exportedAt, List<SymptomTypeDto> symptomTypes, List<SymptomDto> symptoms
});




}
/// @nodoc
class __$ExportFileCopyWithImpl<$Res>
    implements _$ExportFileCopyWith<$Res> {
  __$ExportFileCopyWithImpl(this._self, this._then);

  final _ExportFile _self;
  final $Res Function(_ExportFile) _then;

/// Create a copy of ExportFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? exportedAt = null,Object? symptomTypes = null,Object? symptoms = null,}) {
  return _then(_ExportFile(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,symptomTypes: null == symptomTypes ? _self._symptomTypes : symptomTypes // ignore: cast_nullable_to_non_nullable
as List<SymptomTypeDto>,symptoms: null == symptoms ? _self._symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<SymptomDto>,
  ));
}


}

// dart format on
