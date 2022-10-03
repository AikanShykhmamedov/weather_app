// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherState {
  CityWeather? get localCity => throw _privateConstructorUsedError;
  List<CityWeather> get favoriteCities => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        loaded,
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WeatherLoaded value) loaded,
    required TResult Function(WeatherError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherStateCopyWith<WeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherStateCopyWith<$Res> {
  factory $WeatherStateCopyWith(
          WeatherState value, $Res Function(WeatherState) then) =
      _$WeatherStateCopyWithImpl<$Res>;
  $Res call({CityWeather? localCity, List<CityWeather> favoriteCities});
}

/// @nodoc
class _$WeatherStateCopyWithImpl<$Res> implements $WeatherStateCopyWith<$Res> {
  _$WeatherStateCopyWithImpl(this._value, this._then);

  final WeatherState _value;
  // ignore: unused_field
  final $Res Function(WeatherState) _then;

  @override
  $Res call({
    Object? localCity = freezed,
    Object? favoriteCities = freezed,
  }) {
    return _then(_value.copyWith(
      localCity: localCity == freezed
          ? _value.localCity
          : localCity // ignore: cast_nullable_to_non_nullable
              as CityWeather?,
      favoriteCities: favoriteCities == freezed
          ? _value.favoriteCities
          : favoriteCities // ignore: cast_nullable_to_non_nullable
              as List<CityWeather>,
    ));
  }
}

/// @nodoc
abstract class _$$WeatherLoadedCopyWith<$Res>
    implements $WeatherStateCopyWith<$Res> {
  factory _$$WeatherLoadedCopyWith(
          _$WeatherLoaded value, $Res Function(_$WeatherLoaded) then) =
      __$$WeatherLoadedCopyWithImpl<$Res>;
  @override
  $Res call({CityWeather? localCity, List<CityWeather> favoriteCities});
}

/// @nodoc
class __$$WeatherLoadedCopyWithImpl<$Res>
    extends _$WeatherStateCopyWithImpl<$Res>
    implements _$$WeatherLoadedCopyWith<$Res> {
  __$$WeatherLoadedCopyWithImpl(
      _$WeatherLoaded _value, $Res Function(_$WeatherLoaded) _then)
      : super(_value, (v) => _then(v as _$WeatherLoaded));

  @override
  _$WeatherLoaded get _value => super._value as _$WeatherLoaded;

  @override
  $Res call({
    Object? localCity = freezed,
    Object? favoriteCities = freezed,
  }) {
    return _then(_$WeatherLoaded(
      localCity: localCity == freezed
          ? _value.localCity
          : localCity // ignore: cast_nullable_to_non_nullable
              as CityWeather?,
      favoriteCities: favoriteCities == freezed
          ? _value._favoriteCities
          : favoriteCities // ignore: cast_nullable_to_non_nullable
              as List<CityWeather>,
    ));
  }
}

/// @nodoc

class _$WeatherLoaded extends WeatherLoaded with DiagnosticableTreeMixin {
  const _$WeatherLoaded(
      {required this.localCity,
      required final List<CityWeather> favoriteCities})
      : _favoriteCities = favoriteCities,
        super._();

  @override
  final CityWeather? localCity;
  final List<CityWeather> _favoriteCities;
  @override
  List<CityWeather> get favoriteCities {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteCities);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WeatherState.loaded(localCity: $localCity, favoriteCities: $favoriteCities)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WeatherState.loaded'))
      ..add(DiagnosticsProperty('localCity', localCity))
      ..add(DiagnosticsProperty('favoriteCities', favoriteCities));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherLoaded &&
            const DeepCollectionEquality().equals(other.localCity, localCity) &&
            const DeepCollectionEquality()
                .equals(other._favoriteCities, _favoriteCities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(localCity),
      const DeepCollectionEquality().hash(_favoriteCities));

  @JsonKey(ignore: true)
  @override
  _$$WeatherLoadedCopyWith<_$WeatherLoaded> get copyWith =>
      __$$WeatherLoadedCopyWithImpl<_$WeatherLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        loaded,
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        error,
  }) {
    return loaded(localCity, favoriteCities);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
  }) {
    return loaded?.call(localCity, favoriteCities);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(localCity, favoriteCities);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WeatherLoaded value) loaded,
    required TResult Function(WeatherError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WeatherLoaded extends WeatherState {
  const factory WeatherLoaded(
      {required final CityWeather? localCity,
      required final List<CityWeather> favoriteCities}) = _$WeatherLoaded;
  const WeatherLoaded._() : super._();

  @override
  CityWeather? get localCity;
  @override
  List<CityWeather> get favoriteCities;
  @override
  @JsonKey(ignore: true)
  _$$WeatherLoadedCopyWith<_$WeatherLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WeatherErrorCopyWith<$Res>
    implements $WeatherStateCopyWith<$Res> {
  factory _$$WeatherErrorCopyWith(
          _$WeatherError value, $Res Function(_$WeatherError) then) =
      __$$WeatherErrorCopyWithImpl<$Res>;
  @override
  $Res call({CityWeather? localCity, List<CityWeather> favoriteCities});
}

/// @nodoc
class __$$WeatherErrorCopyWithImpl<$Res>
    extends _$WeatherStateCopyWithImpl<$Res>
    implements _$$WeatherErrorCopyWith<$Res> {
  __$$WeatherErrorCopyWithImpl(
      _$WeatherError _value, $Res Function(_$WeatherError) _then)
      : super(_value, (v) => _then(v as _$WeatherError));

  @override
  _$WeatherError get _value => super._value as _$WeatherError;

  @override
  $Res call({
    Object? localCity = freezed,
    Object? favoriteCities = freezed,
  }) {
    return _then(_$WeatherError(
      localCity: localCity == freezed
          ? _value.localCity
          : localCity // ignore: cast_nullable_to_non_nullable
              as CityWeather?,
      favoriteCities: favoriteCities == freezed
          ? _value._favoriteCities
          : favoriteCities // ignore: cast_nullable_to_non_nullable
              as List<CityWeather>,
    ));
  }
}

/// @nodoc

class _$WeatherError extends WeatherError with DiagnosticableTreeMixin {
  const _$WeatherError(
      {required this.localCity,
      required final List<CityWeather> favoriteCities})
      : _favoriteCities = favoriteCities,
        super._();

  @override
  final CityWeather? localCity;
  final List<CityWeather> _favoriteCities;
  @override
  List<CityWeather> get favoriteCities {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteCities);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WeatherState.error(localCity: $localCity, favoriteCities: $favoriteCities)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WeatherState.error'))
      ..add(DiagnosticsProperty('localCity', localCity))
      ..add(DiagnosticsProperty('favoriteCities', favoriteCities));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherError &&
            const DeepCollectionEquality().equals(other.localCity, localCity) &&
            const DeepCollectionEquality()
                .equals(other._favoriteCities, _favoriteCities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(localCity),
      const DeepCollectionEquality().hash(_favoriteCities));

  @JsonKey(ignore: true)
  @override
  _$$WeatherErrorCopyWith<_$WeatherError> get copyWith =>
      __$$WeatherErrorCopyWithImpl<_$WeatherError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        loaded,
    required TResult Function(
            CityWeather? localCity, List<CityWeather> favoriteCities)
        error,
  }) {
    return error(localCity, favoriteCities);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
  }) {
    return error?.call(localCity, favoriteCities);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        loaded,
    TResult Function(CityWeather? localCity, List<CityWeather> favoriteCities)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(localCity, favoriteCities);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WeatherLoaded value) loaded,
    required TResult Function(WeatherError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WeatherLoaded value)? loaded,
    TResult Function(WeatherError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WeatherError extends WeatherState {
  const factory WeatherError(
      {required final CityWeather? localCity,
      required final List<CityWeather> favoriteCities}) = _$WeatherError;
  const WeatherError._() : super._();

  @override
  CityWeather? get localCity;
  @override
  List<CityWeather> get favoriteCities;
  @override
  @JsonKey(ignore: true)
  _$$WeatherErrorCopyWith<_$WeatherError> get copyWith =>
      throw _privateConstructorUsedError;
}
