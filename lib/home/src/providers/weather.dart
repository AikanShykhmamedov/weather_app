import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/city_weather.dart';
import '../repositories/favorite_cities_repository.dart';
import '../repositories/local_city_repository.dart';

part 'weather.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const WeatherState._();

  const factory WeatherState.loaded({
    required CityWeather? localCity,
    required List<CityWeather> favoriteCities,
  }) = WeatherLoaded;

  const factory WeatherState.error({
    required CityWeather? localCity,
    required List<CityWeather> favoriteCities,
  }) = WeatherError;

  bool get shouldRebuild => map(
        loaded: (_) => true,
        error: (_) => false,
      );

  T buildMap<T>({
    required T Function(WeatherLoaded state) loaded,
  }) =>
      mapOrNull<T>(loaded: loaded)!;
}

/// {@template weather}
/// A class responsible for cities weather.
/// {@endtemplate}
class Weather extends ChangeNotifier {
  /// {@macro weather}
  Weather({
    required LocalCityRepository localCityRepository,
    required FavoriteCitiesRepository favoriteCitiesRepository,
  })  : _localCityRepository = localCityRepository,
        _favoriteCitiesRepository = favoriteCitiesRepository,
        _state = WeatherState.loaded(
          localCity: localCityRepository.city,
          favoriteCities: favoriteCitiesRepository.cities,
        ),
        _isLocationAvailable = true;

  final LocalCityRepository _localCityRepository;
  final FavoriteCitiesRepository _favoriteCitiesRepository;

  WeatherState get state => _state;
  WeatherState _state;

  bool _isLocationAvailable;

  static const _networkTimeout = Duration(seconds: 10);

  /// Sets the location availability.
  ///
  /// If the location becomes available we update a local city (i.e. fetch
  /// current location and weather for that location). If the location
  /// becomes unavailable then we remove the local city.
  Future<void> setLocationAvailability(bool isLocationAvailable) async {
    if (_isLocationAvailable != isLocationAvailable) {
      _isLocationAvailable = isLocationAvailable;

      if (isLocationAvailable) {
        try {
          await _localCityRepository.update().timeout(_networkTimeout);
          _setStateLoaded();
        } catch (_) {
          _setStateError();
          _setStateLoaded();
        }
      } else {
        await _localCityRepository.remove();
        _setStateLoaded();
      }
    }
  }

  /// Fetches new weather from the server.
  Future<void> update() async {
    try {
      await Future.wait([
        if (_isLocationAvailable) _localCityRepository.update(),
        _favoriteCitiesRepository.update(),
      ]).timeout(_networkTimeout);

      _setStateLoaded();
    } catch (_) {
      _setStateError();
      _setStateLoaded();
    }
  }

  /// Adds a new favorite city with corresponding coordinate.
  Future<void> addFavorite(double latitude, double longitude) async {
    try {
      await _favoriteCitiesRepository
          .add(latitude, longitude)
          .timeout(_networkTimeout);

      _setStateLoaded();
    } catch (_) {
      _setStateError();
      _setStateLoaded();
    }
  }

  /// Removes `city` from favorite cities.
  void removeFavorite(CityWeather city) {
    _favoriteCitiesRepository.remove(city);
    _setStateLoaded();
  }

  void _setStateError() {
    _state = WeatherState.error(
      localCity: _localCityRepository.city,
      favoriteCities: _favoriteCitiesRepository.cities,
    );
    notifyListeners();
  }

  void _setStateLoaded() {
    _state = WeatherState.loaded(
      localCity: _localCityRepository.city,
      favoriteCities: _favoriteCitiesRepository.cities,
    );
    notifyListeners();
  }
}
