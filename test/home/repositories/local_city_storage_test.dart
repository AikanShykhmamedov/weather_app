import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/src/repositories/local_city_storage.dart';

import '../cities.dart';

void main() {
  tz.initializeTimeZones();

  const storage = LocalCityStorage();

  group('load', () {
    test('Without cache', () async {
      SharedPreferences.setMockInitialValues({});

      final cityWeather = await storage.load();

      expect(cityWeather, isNull);
    });

    test('With cache', () async {
      SharedPreferences.setMockInitialValues({
        LocalCityStorage.key: jsonEncode(london.toJson()),
      });

      final cityWeather = await storage.load();

      expect(
        cityWeather,
        london,
      );
    });
  });

  group('save', () {
    late final SharedPreferences prefs;

    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('Non null', () async {
      await storage.save(paris);

      expect(
        prefs.getString(LocalCityStorage.key),
        jsonEncode(paris.toJson()),
      );
    });

    test('Null', () async {
      await storage.save(null);

      expect(
        prefs.getString(LocalCityStorage.key),
        isNull,
      );
    });
  });

  test('remove', () async {
    SharedPreferences.setMockInitialValues({
      LocalCityStorage.key: jsonEncode(london.toJson()),
    });

    final prefs = await SharedPreferences.getInstance();

    await storage.remove();

    expect(
      prefs.getString(LocalCityStorage.key),
      isNull,
    );
  });
}
