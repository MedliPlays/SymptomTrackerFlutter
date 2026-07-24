// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymptomType {

 String get id; String get name; bool get hasSeverity;
/// Create a copy of SymptomType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomTypeCopyWith<SymptomType> get copyWith => _$SymptomTypeCopyWithImpl<SymptomType>(this as SymptomType, _$identity);

  /// Serializes this SymptomType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasSeverity, hasSeverity) || other.hasSeverity == hasSeverity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hasSeverity);

@override
String toString() {
  return 'SymptomType(id: $id, name: $name, hasSeverity: $hasSeverity)';
}


}

/// @nodoc
abstract mixin class $SymptomTypeCopyWith<$Res>  {
  factory $SymptomTypeCopyWith(SymptomType value, $Res Function(SymptomType) _then) = _$SymptomTypeCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool hasSeverity
});




}
/// @nodoc
class _$SymptomTypeCopyWithImpl<$Res>
    implements $SymptomTypeCopyWith<$Res> {
  _$SymptomTypeCopyWithImpl(this._self, this._then);

  final SymptomType _self;
  final $Res Function(SymptomType) _then;

/// Create a copy of SymptomType
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


/// Adds pattern-matching-related methods to [SymptomType].
extension SymptomTypePatterns on SymptomType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomType value)  $default,){
final _that = this;
switch (_that) {
case _SymptomType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomType value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomType() when $default != null:
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
case _SymptomType() when $default != null:
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
case _SymptomType():
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
case _SymptomType() when $default != null:
return $default(_that.id,_that.name,_that.hasSeverity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SymptomType implements SymptomType {
  const _SymptomType({required this.id, required this.name, this.hasSeverity = true});
  factory _SymptomType.fromJson(Map<String, dynamic> json) => _$SymptomTypeFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  bool hasSeverity;

/// Create a copy of SymptomType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomTypeCopyWith<_SymptomType> get copyWith => __$SymptomTypeCopyWithImpl<_SymptomType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymptomTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasSeverity, hasSeverity) || other.hasSeverity == hasSeverity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hasSeverity);

@override
String toString() {
  return 'SymptomType(id: $id, name: $name, hasSeverity: $hasSeverity)';
}


}

/// @nodoc
abstract mixin class _$SymptomTypeCopyWith<$Res> implements $SymptomTypeCopyWith<$Res> {
  factory _$SymptomTypeCopyWith(_SymptomType value, $Res Function(_SymptomType) _then) = __$SymptomTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool hasSeverity
});




}
/// @nodoc
class __$SymptomTypeCopyWithImpl<$Res>
    implements _$SymptomTypeCopyWith<$Res> {
  __$SymptomTypeCopyWithImpl(this._self, this._then);

  final _SymptomType _self;
  final $Res Function(_SymptomType) _then;

/// Create a copy of SymptomType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? hasSeverity = null,}) {
  return _then(_SymptomType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasSeverity: null == hasSeverity ? _self.hasSeverity : hasSeverity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
