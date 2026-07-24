// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SymptomFilter {

 bool get dateEnabled; DateTime? get after; DateTime? get before; String? get typeId;
/// Create a copy of SymptomFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomFilterCopyWith<SymptomFilter> get copyWith => _$SymptomFilterCopyWithImpl<SymptomFilter>(this as SymptomFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomFilter&&(identical(other.dateEnabled, dateEnabled) || other.dateEnabled == dateEnabled)&&(identical(other.after, after) || other.after == after)&&(identical(other.before, before) || other.before == before)&&(identical(other.typeId, typeId) || other.typeId == typeId));
}


@override
int get hashCode => Object.hash(runtimeType,dateEnabled,after,before,typeId);

@override
String toString() {
  return 'SymptomFilter(dateEnabled: $dateEnabled, after: $after, before: $before, typeId: $typeId)';
}


}

/// @nodoc
abstract mixin class $SymptomFilterCopyWith<$Res>  {
  factory $SymptomFilterCopyWith(SymptomFilter value, $Res Function(SymptomFilter) _then) = _$SymptomFilterCopyWithImpl;
@useResult
$Res call({
 bool dateEnabled, DateTime? after, DateTime? before, String? typeId
});




}
/// @nodoc
class _$SymptomFilterCopyWithImpl<$Res>
    implements $SymptomFilterCopyWith<$Res> {
  _$SymptomFilterCopyWithImpl(this._self, this._then);

  final SymptomFilter _self;
  final $Res Function(SymptomFilter) _then;

/// Create a copy of SymptomFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateEnabled = null,Object? after = freezed,Object? before = freezed,Object? typeId = freezed,}) {
  return _then(_self.copyWith(
dateEnabled: null == dateEnabled ? _self.dateEnabled : dateEnabled // ignore: cast_nullable_to_non_nullable
as bool,after: freezed == after ? _self.after : after // ignore: cast_nullable_to_non_nullable
as DateTime?,before: freezed == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as DateTime?,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SymptomFilter].
extension SymptomFilterPatterns on SymptomFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomFilter value)  $default,){
final _that = this;
switch (_that) {
case _SymptomFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomFilter value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dateEnabled,  DateTime? after,  DateTime? before,  String? typeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomFilter() when $default != null:
return $default(_that.dateEnabled,_that.after,_that.before,_that.typeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dateEnabled,  DateTime? after,  DateTime? before,  String? typeId)  $default,) {final _that = this;
switch (_that) {
case _SymptomFilter():
return $default(_that.dateEnabled,_that.after,_that.before,_that.typeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dateEnabled,  DateTime? after,  DateTime? before,  String? typeId)?  $default,) {final _that = this;
switch (_that) {
case _SymptomFilter() when $default != null:
return $default(_that.dateEnabled,_that.after,_that.before,_that.typeId);case _:
  return null;

}
}

}

/// @nodoc


class _SymptomFilter extends SymptomFilter {
  const _SymptomFilter({this.dateEnabled = false, this.after, this.before, this.typeId}): super._();
  

@override@JsonKey() final  bool dateEnabled;
@override final  DateTime? after;
@override final  DateTime? before;
@override final  String? typeId;

/// Create a copy of SymptomFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomFilterCopyWith<_SymptomFilter> get copyWith => __$SymptomFilterCopyWithImpl<_SymptomFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomFilter&&(identical(other.dateEnabled, dateEnabled) || other.dateEnabled == dateEnabled)&&(identical(other.after, after) || other.after == after)&&(identical(other.before, before) || other.before == before)&&(identical(other.typeId, typeId) || other.typeId == typeId));
}


@override
int get hashCode => Object.hash(runtimeType,dateEnabled,after,before,typeId);

@override
String toString() {
  return 'SymptomFilter(dateEnabled: $dateEnabled, after: $after, before: $before, typeId: $typeId)';
}


}

/// @nodoc
abstract mixin class _$SymptomFilterCopyWith<$Res> implements $SymptomFilterCopyWith<$Res> {
  factory _$SymptomFilterCopyWith(_SymptomFilter value, $Res Function(_SymptomFilter) _then) = __$SymptomFilterCopyWithImpl;
@override @useResult
$Res call({
 bool dateEnabled, DateTime? after, DateTime? before, String? typeId
});




}
/// @nodoc
class __$SymptomFilterCopyWithImpl<$Res>
    implements _$SymptomFilterCopyWith<$Res> {
  __$SymptomFilterCopyWithImpl(this._self, this._then);

  final _SymptomFilter _self;
  final $Res Function(_SymptomFilter) _then;

/// Create a copy of SymptomFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateEnabled = null,Object? after = freezed,Object? before = freezed,Object? typeId = freezed,}) {
  return _then(_SymptomFilter(
dateEnabled: null == dateEnabled ? _self.dateEnabled : dateEnabled // ignore: cast_nullable_to_non_nullable
as bool,after: freezed == after ? _self.after : after // ignore: cast_nullable_to_non_nullable
as DateTime?,before: freezed == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as DateTime?,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
