import 'package:flutter_test/flutter_test.dart';
import 'package:location_api/location_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/home/src/repositories/local_city_repository.dart';
import 'package:weather_app/home/src/repositories/local_city_storage.dart';

import '../cities.dart';

class MockLocalCityStorage extends Mock implements LocalCityStorage {}

class MockLocationApi extends Mock implements LocationApi {}

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  tz.initializeTimeZones();

  final storage = MockLocalCityStorage();
  final locationApi = MockLocationApi();
  final weatherApi = MockWeatherApi();
  final repository = LocalCityRepository(
    storage: storage,
    locationApi: locationApi,
    weatherApi: weatherApi,
  );

  test('load', () async {
    when(() => storage.load()).thenAnswer((_) async => london);

    await repository.initialize();

    expect(
      repository.city,
      london,
    );

    verify(() => storage.load()).called(1);
  });

  test('remove', () async {
    when(() => storage.remove()).thenAnswer((_) async {});

    await repository.remove();

    expect(repository.city, isNull);

    verify(() => storage.remove()).called(1);
  });

  test('update', () async {
    final city = madridFromForecast;
    final forecast = madridForecast;

    when(() => locationApi.getCurrentPosition())
        .thenAnswer((_) async => LatLng(city.latitude, city.longitude));
    when(() => weatherApi.getForecast(city.latitude, city.longitude))
        .thenAnswer((_) async => forecast);
    when(() => storage.save(city)).thenAnswer((_) async {});

    await repository.update();

    expect(repository.city, city);

    verify(() => locationApi.getCurrentPosition()).called(1);
    verify(() => weatherApi.getForecast(city.latitude, city.longitude)).called(1);
    verify(() => storage.save(city)).called(1);
  });
}
