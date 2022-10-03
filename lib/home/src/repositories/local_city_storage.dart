import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/home/src/models/city_weather.dart';

/// {@template local_city_storage}
/// Manages a local city in SharedPreferences store.
/// {@endtemplate}
class LocalCityStorage {
  /// {@macro local_city_storage}
  const LocalCityStorage();

  static const String key = 'local_city_weather';

  /// Loads a local city from cache.
  Future<CityWeather?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(key);

    if (encoded == null) {
      return null;
    }

    final decoded = jsonDecode(encoded);

    return CityWeather.fromJson(decoded);
  }

  /// Saves `cityWeather` to cache.
  Future<void> save(CityWeather? cityWeather) async {
    final prefs = await SharedPreferences.getInstance();

    if (cityWeather == null) {
      await prefs.remove(key);
    } else {
      final encoded = jsonEncode(cityWeather.toJson());

      await prefs.setString(key, encoded);
    }
  }

  /// Removes the local city from cache.
  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}
