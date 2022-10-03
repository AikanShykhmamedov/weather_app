import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/src/repositories/favorite_cities_storage.dart';

import '../cities.dart';

void main() {
  tz.initializeTimeZones();

  const storage = FavoriteCitiesStorage();

  group('load', () {
    test('Without cache', () async {
      SharedPreferences.setMockInitialValues({});

      final cities = await storage.load();

      expect(cities, isNull);
    });

    test('With cache', () async {
      SharedPreferences.setMockInitialValues({
        FavoriteCitiesStorage.key: jsonEncode(
          [london.toJson(), paris.toJson()],
        ),
      });

      final cities = await storage.load();

      expect(cities, [london, paris]);
    });
  });

  group('save', () {
    late final SharedPreferences prefs;

    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('Save non empty list', () async {
      await storage.save([london]);

      expect(
        prefs.getString(FavoriteCitiesStorage.key),
        jsonEncode([london.toJson()]),
      );
    });

    test('Save empty list', () async {
      await storage.save([]);

      expect(
        prefs.getString(FavoriteCitiesStorage.key),
        '[]',
      );
    });
  });
}
