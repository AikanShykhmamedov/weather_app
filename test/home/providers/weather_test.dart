import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/src/providers/weather.dart';
import 'package:weather_app/home/src/repositories/favorite_cities_repository.dart';
import 'package:weather_app/home/src/repositories/local_city_repository.dart';

import '../cities.dart';

class MockLocalCityRepository extends Mock implements LocalCityRepository {}

class MockFavoriteCitiesRepository extends Mock
    implements FavoriteCitiesRepository {}

void main() async {
  tz.initializeTimeZones();

  final localCityRepository = MockLocalCityRepository();
  final favoriteCitiesRepository = MockFavoriteCitiesRepository();

  late Weather weather;
  late StreamController<WeatherState> streamController;
  late Stream<WeatherState> resultStream;

  setUp(() {
    streamController = StreamController<WeatherState>();
    resultStream = streamController.stream;
  });

  tearDown(() async {
    await streamController.close();
  });

  group('setLocationAvailability', () {
    setUpAll(() {
      when(() => localCityRepository.city).thenReturn(london);
      when(() => favoriteCitiesRepository.cities).thenReturn(const []);
      when(() => localCityRepository.remove()).thenAnswer((_) async {});
    });

    group('Without exception', () {
      setUpAll(() {
        weather = Weather(
          localCityRepository: localCityRepository,
          favoriteCitiesRepository: favoriteCitiesRepository,
        );

        weather.addListener(() {
          streamController.add(weather.state);
        });
      });

      tearDownAll(() {
        weather.dispose();
      });

      test('True -> False', () async {
        when(() => localCityRepository.city).thenReturn(null);

        await weather.setLocationAvailability(false);

        expect(
          resultStream,
          emits(const WeatherState.loaded(
            localCity: null,
            favoriteCities: [],
          )),
        );

        verify(() => localCityRepository.remove()).called(1);
      });

      test('False -> True', () async {
        when(() => localCityRepository.update()).thenAnswer((_) async {});
        when(() => localCityRepository.city).thenReturn(london);

        await weather.setLocationAvailability(true);

        expect(
          resultStream,
          emits(WeatherState.loaded(
            localCity: london,
            favoriteCities: [],
          )),
        );

        verify(() => localCityRepository.update()).called(1);
      });
    });

    group('With exception', () {
      setUpAll(() async {
        weather = Weather(
          localCityRepository: localCityRepository,
          favoriteCitiesRepository: favoriteCitiesRepository,
        );

        await weather.setLocationAvailability(false);

        weather.addListener(() {
          streamController.add(weather.state);
        });
      });

      tearDownAll(() {
        weather.dispose();
      });

      test('False -> True', () async {
        when(() => localCityRepository.update())
            .thenAnswer((_) async => throw Exception());
        when(() => localCityRepository.city).thenReturn(null);

        await weather.setLocationAvailability(true);

        expect(
          resultStream,
          emitsInOrder([
            const WeatherState.error(
              localCity: null,
              favoriteCities: [],
            ),
            const WeatherState.loaded(
              localCity: null,
              favoriteCities: [],
            )
          ]),
        );

        verify(() => localCityRepository.update()).called(1);
      });
    });
  });

  group('update', () {
    setUp(() {
      when(() => localCityRepository.city).thenReturn(madrid);
      when(() => favoriteCitiesRepository.cities).thenReturn([madrid]);

      weather = Weather(
        localCityRepository: localCityRepository,
        favoriteCitiesRepository: favoriteCitiesRepository,
      );

      weather.addListener(() {
        streamController.add(weather.state);
      });

      reset(localCityRepository);
      reset(favoriteCitiesRepository);
    });

    tearDown(() {
      weather.dispose();
    });

    test('Without exception', () async {
      when(() => localCityRepository.update()).thenAnswer((_) async {});
      when(() => favoriteCitiesRepository.update()).thenAnswer((_) async {});
      when(() => localCityRepository.city).thenReturn(madridFromForecast);
      when(() => favoriteCitiesRepository.cities)
          .thenReturn([madridFromForecast]);

      await weather.update();

      expect(
        resultStream,
        emits(WeatherState.loaded(
          localCity: madridFromForecast,
          favoriteCities: [madridFromForecast],
        )),
      );

      verify(() => localCityRepository.update()).called(1);
      verify(() => localCityRepository.city).called(1);
      verify(() => favoriteCitiesRepository.update()).called(1);
      verify(() => favoriteCitiesRepository.cities).called(1);
    });

    test('With exception', () async {
      when(() => localCityRepository.update())
          .thenAnswer((_) async => throw Exception());
      when(() => favoriteCitiesRepository.update())
          .thenAnswer((_) async => throw Exception());
      when(() => localCityRepository.city).thenReturn(madrid);
      when(() => favoriteCitiesRepository.cities).thenReturn([madrid]);

      await weather.update();

      expect(
        resultStream,
        emitsInOrder([
          WeatherState.error(
            localCity: madrid,
            favoriteCities: [madrid],
          ),
          WeatherState.loaded(
            localCity: madrid,
            favoriteCities: [madrid],
          ),
        ]),
      );

      verify(() => localCityRepository.update()).called(1);
      verify(() => localCityRepository.city).called(2);
      verify(() => favoriteCitiesRepository.update()).called(1);
      verify(() => favoriteCitiesRepository.cities).called(2);
    });
  });

  group('addFavorite|removeFavorite', () {
    setUp(() {
      when(() => localCityRepository.city).thenReturn(null);
      when(() => favoriteCitiesRepository.cities).thenReturn([london]);

      weather = Weather(
        localCityRepository: localCityRepository,
        favoriteCitiesRepository: favoriteCitiesRepository,
      );

      weather.addListener(() {
        streamController.add(weather.state);
      });
    });

    tearDown(() {
      weather.dispose();
    });

    group('Add a city', () {
      test('Without exception', () async {
        when(
          () => favoriteCitiesRepository.add(paris.latitude, paris.longitude),
        ).thenAnswer((_) async {});
        when(() => favoriteCitiesRepository.cities).thenReturn([london, paris]);

        await weather.addFavorite(paris.latitude, paris.longitude);

        expect(
          resultStream,
          emitsInOrder([
            WeatherState.loaded(
              localCity: null,
              favoriteCities: [london, paris],
            ),
          ]),
        );

        verify(
          () => favoriteCitiesRepository.add(paris.latitude, paris.longitude),
        ).called(1);
      });

      test('With exception', () async {
        when(
          () => favoriteCitiesRepository.add(paris.latitude, paris.longitude),
        ).thenAnswer((_) async => throw Exception());
        when(() => favoriteCitiesRepository.cities).thenReturn([london]);

        await weather.addFavorite(paris.latitude, paris.longitude);

        expect(
          resultStream,
          emitsInOrder([
            WeatherState.error(
              localCity: null,
              favoriteCities: [london],
            ),
            WeatherState.loaded(
              localCity: null,
              favoriteCities: [london],
            ),
          ]),
        );

        verify(
          () => favoriteCitiesRepository.add(paris.latitude, paris.longitude),
        ).called(1);
      });
    });

    test('Remove a city', () async {
      when(() => favoriteCitiesRepository.remove(london))
          .thenAnswer((_) async {});
      when(() => favoriteCitiesRepository.cities).thenReturn([]);

      weather.removeFavorite(london);

      expect(
        resultStream,
        emits(
          const WeatherState.loaded(
            localCity: null,
            favoriteCities: [],
          ),
        ),
      );

      verify(() => favoriteCitiesRepository.remove(london)).called(1);
    });
  });
}
