import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/city_search/src/providers/search_autocomplete.dart';

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  final weatherApi = MockWeatherApi();
  final autocomplete = SearchAutocomplete(client: weatherApi);

  late StreamController<SearchAutocompleteState> streamController;
  late Stream<SearchAutocompleteState> resultStream;

  autocomplete.addListener(() {
    streamController.add(autocomplete.state);
  });

  setUp(() {
    streamController = StreamController<SearchAutocompleteState>();
    resultStream = streamController.stream;
  });

  tearDown(() {
    streamController.close();
  });

  tearDownAll(() {
    autocomplete.dispose();
  });

  test('Initial', () {
    // Add initial value
    streamController.add(autocomplete.state);

    expect(
      resultStream,
      emits(const SearchAutocompleteState.initial()),
    );
  });

  test('Query', () {
    when(() => weatherApi.getCompletion('London'))
        .thenAnswer((_) async => [city1, city2]);

    autocomplete.onQuery('London');

    expect(
      resultStream,
      emitsInOrder([
        const SearchAutocompleteState.loading(),
        const SearchAutocompleteState.success(cities: [city1, city2]),
      ]),
    );
  });

  test('Throws exception', () async {
    when(() => weatherApi.getCompletion(any()))
        .thenAnswer((_) async => throw WeatherApiException());

    autocomplete.onQuery('London');

    await expectLater(
      resultStream,
      emitsInOrder([
        const SearchAutocompleteState.loading(),
        const SearchAutocompleteState.error(),
      ]),
    );
  });

  test('Empty query', () {
    autocomplete.onQuery('');

    expect(
      resultStream,
      emits(const SearchAutocompleteState.initial()),
    );
  });

  test('Waits delay', () {
    when(() => weatherApi.getCompletion('Lon')).thenAnswer(
      (_) async => [city1, city2],
    );

    autocomplete.onQuery('Lon');

    when(() => weatherApi.getCompletion('Lond')).thenAnswer(
      (_) async => const [city1],
    );

    autocomplete.onQuery('Lond');

    expect(
      resultStream,
      emitsInOrder([
        const SearchAutocompleteState.loading(),
        const SearchAutocompleteState.success(cities: [city1]),
      ]),
    );
  });
}

const city1 = Location(
  'London',
  'City of London, Greater London',
  'United Kingdom',
  51.52,
  -0.11,
  null,
);

const city2 = Location(
  'Lambeth',
  'Lambeth, Greater London',
  'United Kingdom',
  51.49,
  -0.12,
  null,
);
