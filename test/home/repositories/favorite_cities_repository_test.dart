import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/home/home.dart';
import 'package:weather_app/home/src/repositories/favorite_cities_storage.dart';

import '../cities.dart';

class MockFavoriteCitiesStorage extends Mock implements FavoriteCitiesStorage {}

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  tz.initializeTimeZones();

  final storage = MockFavoriteCitiesStorage();
  final weatherApi = MockWeatherApi();

  group('load', () {
    late FavoriteCitiesRepository repository;

    setUp(() {
      repository = FavoriteCitiesRepository(
        storage: storage,
        weatherApi: weatherApi,
      );
    });

    test('Empty cache (the first loading)', () async {
      when(() => storage.load()).thenAnswer((_) async => null);

      await repository.initialize();

      expect(
        repository.cities,
        [FavoriteCitiesRepository.defaultCity],
      );

      verify(() => storage.load()).called(1);
    });

    test('Non empty cache', () async {
      final cities = [london, paris];

      when(() => storage.load()).thenAnswer((_) async => cities);

      await repository.initialize();

      expect(repository.cities, cities);

      verify(() => storage.load()).called(1);
    });
  });

  group('add|remove', () {
    late final FavoriteCitiesRepository repository;

    final city = madridFromForecast;
    final forecast = madridForecast;

    setUpAll(() async {
      repository = FavoriteCitiesRepository(
        storage: storage,
        weatherApi: weatherApi,
      );

      when(() => storage.load()).thenAnswer((_) async => []);

      await repository.initialize();
    });

    test('Add a city', () async {
      when(() => weatherApi.getForecast(city.latitude, city.longitude))
          .thenAnswer((_) async => forecast);

      when(() => storage.save([city])).thenAnswer((_) async {});

      await repository.add(city.latitude, city.longitude);

      expect(repository.cities, [city]);

      verify(() => weatherApi.getForecast(city.latitude, city.longitude))
          .called(1);
      verify(() => storage.save([city])).called(1);
    });

    test('Remove a city', () async {
      when(() => storage.save([])).thenAnswer((_) async {});

      await repository.remove(city);

      expect(repository.cities, <CityWeather>[]);

      verify(() => storage.save([])).called(1);
    });
  });

  group('update', () {
    late FavoriteCitiesRepository repository;

    final initialCities = [madrid];

    setUp(() async {
      repository = FavoriteCitiesRepository(
        storage: storage,
        weatherApi: weatherApi,
      );

      when(() => storage.load()).thenAnswer((_) async => initialCities);

      await repository.initialize();
    });

    test('Updates one city', () async {
      when(() => weatherApi.getForecast(madrid.latitude, madrid.longitude))
          .thenAnswer((_) async => madridForecast);

      when(() => storage.save([madridFromForecast])).thenAnswer((_) async {});

      await repository.update();

      expect(repository.cities, [madridFromForecast]);

      verify(() => weatherApi.getForecast(madrid.latitude, madrid.longitude))
          .called(1);
      verify(() => storage.save([madridFromForecast])).called(1);
    });

    test('Throws exception', () async {
      when(() => weatherApi.getForecast(madrid.latitude, madrid.longitude))
          .thenAnswer((_) async => brokenMadridForecast);

      final future = repository.update();

      await expectLater(
        future,
        throwsA(isA<Exception>()),
      );

      expect(repository.cities, initialCities);

      verify(() => weatherApi.getForecast(madrid.latitude, madrid.longitude))
          .called(1);
      verifyNever(() => storage.save(any()));
    });
  });
}
