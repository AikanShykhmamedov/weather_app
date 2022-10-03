import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/city_weather.dart';

/// {@template favorite_cities_storage}
/// Manages a local city in SharedPreferences store.
/// {@endtemplate}
class FavoriteCitiesStorage {
  /// {@macro favorite_cities_storage}
  const FavoriteCitiesStorage();

  static const String key = 'favorite_cities_weather';

  /// Loads favorite cities from cache.
  Future<List<CityWeather>?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(key);

    if (encoded == null) {
      return null;
    }

    final jsonArray =
        (jsonDecode(encoded) as List).cast<Map<String, dynamic>>();

    return jsonArray.map<CityWeather>(CityWeather.fromJson).toList();
  }

  /// Saves `favoriteCities` to cache.
  Future<void> save(List<CityWeather> favoriteCities) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      favoriteCities.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
    );

    await prefs.setString(key, encoded);
  }
}
