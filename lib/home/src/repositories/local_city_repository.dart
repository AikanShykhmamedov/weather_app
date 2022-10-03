import 'package:location_api/location_api.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/app/app_config.dart';

import '../models/city_weather.dart';
import 'local_city_storage.dart';

/// {@template local_city_repository}
/// A repository responsible for managing a local city.
/// {@endtemplate}
class LocalCityRepository {
  /// {@macro local_city_repository}
  LocalCityRepository({
    LocalCityStorage? storage,
    LocationApi? locationApi,
    WeatherApi? weatherApi,
  })  : _storage = storage ?? const LocalCityStorage(),
        _locationApi = locationApi ?? const LocationApi(),
        _weatherApi = weatherApi ?? WeatherApi(key: AppConfig.weatherApiKey);

  final LocalCityStorage _storage;
  final LocationApi _locationApi;
  final WeatherApi _weatherApi;

  /// Local city.
  CityWeather? get city => _city;
  CityWeather? _city;

  /// Loads a local city from cache.
  Future<void> initialize() async {
    _city = await _storage.load();
  }

  /// Removes the local city and updates cache.
  Future<void> remove() async {
    _city = null;
    await _storage.remove();
  }

  /// Updates the local city.
  Future<void> update() async {
    final latLng = await _locationApi.getCurrentPosition();
    final forecast = await _weatherApi.getForecast(
      latLng.latitude,
      latLng.longitude,
    );

    _city = CityWeather.fromForecast(forecast);

    await _storage.save(_city);
  }
}
