// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_autocomplete.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchAutocompleteState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<Location> cities) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchAutocompleteInitial value) initial,
    required TResult Function(SearchAutocompleteLoading value) loading,
    required TResult Function(SearchAutocompleteError value) error,
    required TResult Function(SearchAutocompleteSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchAutocompleteStateCopyWith<$Res> {
  factory $SearchAutocompleteStateCopyWith(SearchAutocompleteState value,
          $Res Function(SearchAutocompleteState) then) =
      _$SearchAutocompleteStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchAutocompleteStateCopyWithImpl<$Res>
    implements $SearchAutocompleteStateCopyWith<$Res> {
  _$SearchAutocompleteStateCopyWithImpl(this._value, this._then);

  final SearchAutocompleteState _value;
  // ignore: unused_field
  final $Res Function(SearchAutocompleteState) _then;
}

/// @nodoc
abstract class _$$SearchAutocompleteInitialCopyWith<$Res> {
  factory _$$SearchAutocompleteInitialCopyWith(
          _$SearchAutocompleteInitial value,
          $Res Function(_$SearchAutocompleteInitial) then) =
      __$$SearchAutocompleteInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchAutocompleteInitialCopyWithImpl<$Res>
    extends _$SearchAutocompleteStateCopyWithImpl<$Res>
    implements _$$SearchAutocompleteInitialCopyWith<$Res> {
  __$$SearchAutocompleteInitialCopyWithImpl(_$SearchAutocompleteInitial _value,
      $Res Function(_$SearchAutocompleteInitial) _then)
      : super(_value, (v) => _then(v as _$SearchAutocompleteInitial));

  @override
  _$SearchAutocompleteInitial get _value =>
      super._value as _$SearchAutocompleteInitial;
}

/// @nodoc

class _$SearchAutocompleteInitial implements SearchAutocompleteInitial {
  const _$SearchAutocompleteInitial();

  @override
  String toString() {
    return 'SearchAutocompleteState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAutocompleteInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<Location> cities) success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchAutocompleteInitial value) initial,
    required TResult Function(SearchAutocompleteLoading value) loading,
    required TResult Function(SearchAutocompleteError value) error,
    required TResult Function(SearchAutocompleteSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchAutocompleteInitial implements SearchAutocompleteState {
  const factory SearchAutocompleteInitial() = _$SearchAutocompleteInitial;
}

/// @nodoc
abstract class _$$SearchAutocompleteLoadingCopyWith<$Res> {
  factory _$$SearchAutocompleteLoadingCopyWith(
          _$SearchAutocompleteLoading value,
          $Res Function(_$SearchAutocompleteLoading) then) =
      __$$SearchAutocompleteLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchAutocompleteLoadingCopyWithImpl<$Res>
    extends _$SearchAutocompleteStateCopyWithImpl<$Res>
    implements _$$SearchAutocompleteLoadingCopyWith<$Res> {
  __$$SearchAutocompleteLoadingCopyWithImpl(_$SearchAutocompleteLoading _value,
      $Res Function(_$SearchAutocompleteLoading) _then)
      : super(_value, (v) => _then(v as _$SearchAutocompleteLoading));

  @override
  _$SearchAutocompleteLoading get _value =>
      super._value as _$SearchAutocompleteLoading;
}

/// @nodoc

class _$SearchAutocompleteLoading implements SearchAutocompleteLoading {
  const _$SearchAutocompleteLoading();

  @override
  String toString() {
    return 'SearchAutocompleteState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAutocompleteLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<Location> cities) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchAutocompleteInitial value) initial,
    required TResult Function(SearchAutocompleteLoading value) loading,
    required TResult Function(SearchAutocompleteError value) error,
    required TResult Function(SearchAutocompleteSuccess value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SearchAutocompleteLoading implements SearchAutocompleteState {
  const factory SearchAutocompleteLoading() = _$SearchAutocompleteLoading;
}

/// @nodoc
abstract class _$$SearchAutocompleteErrorCopyWith<$Res> {
  factory _$$SearchAutocompleteErrorCopyWith(_$SearchAutocompleteError value,
          $Res Function(_$SearchAutocompleteError) then) =
      __$$SearchAutocompleteErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchAutocompleteErrorCopyWithImpl<$Res>
    extends _$SearchAutocompleteStateCopyWithImpl<$Res>
    implements _$$SearchAutocompleteErrorCopyWith<$Res> {
  __$$SearchAutocompleteErrorCopyWithImpl(_$SearchAutocompleteError _value,
      $Res Function(_$SearchAutocompleteError) _then)
      : super(_value, (v) => _then(v as _$SearchAutocompleteError));

  @override
  _$SearchAutocompleteError get _value =>
      super._value as _$SearchAutocompleteError;
}

/// @nodoc

class _$SearchAutocompleteError implements SearchAutocompleteError {
  const _$SearchAutocompleteError();

  @override
  String toString() {
    return 'SearchAutocompleteState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAutocompleteError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<Location> cities) success,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchAutocompleteInitial value) initial,
    required TResult Function(SearchAutocompleteLoading value) loading,
    required TResult Function(SearchAutocompleteError value) error,
    required TResult Function(SearchAutocompleteSuccess value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SearchAutocompleteError implements SearchAutocompleteState {
  const factory SearchAutocompleteError() = _$SearchAutocompleteError;
}

/// @nodoc
abstract class _$$SearchAutocompleteSuccessCopyWith<$Res> {
  factory _$$SearchAutocompleteSuccessCopyWith(
          _$SearchAutocompleteSuccess value,
          $Res Function(_$SearchAutocompleteSuccess) then) =
      __$$SearchAutocompleteSuccessCopyWithImpl<$Res>;
  $Res call({List<Location> cities});
}

/// @nodoc
class __$$SearchAutocompleteSuccessCopyWithImpl<$Res>
    extends _$SearchAutocompleteStateCopyWithImpl<$Res>
    implements _$$SearchAutocompleteSuccessCopyWith<$Res> {
  __$$SearchAutocompleteSuccessCopyWithImpl(_$SearchAutocompleteSuccess _value,
      $Res Function(_$SearchAutocompleteSuccess) _then)
      : super(_value, (v) => _then(v as _$SearchAutocompleteSuccess));

  @override
  _$SearchAutocompleteSuccess get _value =>
      super._value as _$SearchAutocompleteSuccess;

  @override
  $Res call({
    Object? cities = freezed,
  }) {
    return _then(_$SearchAutocompleteSuccess(
      cities: cities == freezed
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ));
  }
}

/// @nodoc

class _$SearchAutocompleteSuccess implements SearchAutocompleteSuccess {
  const _$SearchAutocompleteSuccess({required final List<Location> cities})
      : _cities = cities;

  final List<Location> _cities;
  @override
  List<Location> get cities {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  String toString() {
    return 'SearchAutocompleteState.success(cities: $cities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAutocompleteSuccess &&
            const DeepCollectionEquality().equals(other._cities, _cities));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cities));

  @JsonKey(ignore: true)
  @override
  _$$SearchAutocompleteSuccessCopyWith<_$SearchAutocompleteSuccess>
      get copyWith => __$$SearchAutocompleteSuccessCopyWithImpl<
          _$SearchAutocompleteSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<Location> cities) success,
  }) {
    return success(cities);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
  }) {
    return success?.call(cities);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<Location> cities)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(cities);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchAutocompleteInitial value) initial,
    required TResult Function(SearchAutocompleteLoading value) loading,
    required TResult Function(SearchAutocompleteError value) error,
    required TResult Function(SearchAutocompleteSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchAutocompleteInitial value)? initial,
    TResult Function(SearchAutocompleteLoading value)? loading,
    TResult Function(SearchAutocompleteError value)? error,
    TResult Function(SearchAutocompleteSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SearchAutocompleteSuccess implements SearchAutocompleteState {
  const factory SearchAutocompleteSuccess(
      {required final List<Location> cities}) = _$SearchAutocompleteSuccess;

  List<Location> get cities;
  @JsonKey(ignore: true)
  _$$SearchAutocompleteSuccessCopyWith<_$SearchAutocompleteSuccess>
      get copyWith => throw _privateConstructorUsedError;
}
