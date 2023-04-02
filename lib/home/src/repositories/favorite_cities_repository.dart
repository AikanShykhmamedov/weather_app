import 'dart:collection';

import 'package:timezone/timezone.dart' as tz;
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/app/app_config.dart';

import '../models/city_weather.dart';
import 'favorite_cities_storage.dart';

/// {@template favorite_cities_repository}
/// A repository responsible for managing favorite cities.
/// {@endtemplate}
class FavoriteCitiesRepository {
  /// {@macro favorite_cities_repository}
  FavoriteCitiesRepository({
    FavoriteCitiesStorage? storage,
    WeatherApi? weatherApi,
  })  : _storage = storage ?? const FavoriteCitiesStorage(),
        _weatherApi = weatherApi ?? WeatherApi(key: AppConfig.weatherApiKey);

  final FavoriteCitiesStorage _storage;
  final WeatherApi _weatherApi;

  /// The list of favorite cities.
  List<CityWeather> get cities => UnmodifiableListView(_cities);
  late List<CityWeather> _cities;

  /// This city is used when a user opens the app for the first time.
  static final defaultCity = CityWeather(
    latitude: 48.87,
    longitude: 2.33,
    name: 'Paris',
    timeZone: tz.getLocation('Europe/Paris'),
    type: WeatherType.fewClouds,
    temperature: 15,
    temperatureBefore: 13,
    temperatureAfter: 17,
    sunrise: DateTime.fromMillisecondsSinceEpoch(
      6 * 60 * 60 * 1000,
      isUtc: true,
    ),
    sunset: DateTime.fromMillisecondsSinceEpoch(
      20 * 60 * 60 * 1000,
      isUtc: true,
    ),
    wind: 5,
    pressure: 1030,
  );

  /// Loads favorite cities from cache.
  ///
  /// Returns [[_defaultCity]] if it is the first loading.
  Future<void> initialize() async {
    final cities = await _storage.load();

    _cities = cities ?? [defaultCity];
  }

  /// Adds this city to favorite cities and updates cache.
  Future<void> add(double latitude, double longitude) async {
    final forecast = await _weatherApi.getForecast(latitude, longitude);
    final city = CityWeather.fromForecast(forecast);

    _cities = [..._cities, city];

    await _storage.save(_cities);
  }

  /// Removes this city from favorite cities and updates cache.
  Future<void> remove(CityWeather city) async {
    final cities = [..._cities];
    cities.remove(city);
    _cities = cities;

    await _storage.save(_cities);
  }

  /// Updates cities weathers and saves it to cache.
  Future<void> update() async {
    final forecasts = await Future.wait(
      _cities.map<Future<Forecast>>(
        (city) => _weatherApi.getForecast(city.latitude, city.longitude),
      ),
    );

    // First map forecasts to List<CityWeather>. If we get an error while
    // creating instances we do not change _cities.
    final cities =
        forecasts.map<CityWeather>(CityWeather.fromForecast).toList();

    _cities = cities;

    await _storage.save(_cities);
  }
}
