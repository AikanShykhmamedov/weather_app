import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/home/src/models/weather_measure.dart';
import 'package:weather_app/home/src/repositories/preferences_repository.dart';
import 'package:weather_app/home/src/repositories/preferences_storage.dart';

class MockPreferencesStorage extends Mock implements PreferencesStorage {}

void main() {
  final storage = MockPreferencesStorage();
  final repository = PreferencesRepository(storage: storage);

  const initialTemperatureMeasure = TemperatureMeasure.celsius;
  const initialWindMeasure = WindMeasure.mPerS;
  const initialPressureMeasure = PressureMeasure.hPa;

  const savedTemperatureMeasure = TemperatureMeasure.fahrenheit;
  const savedWindMeasure = WindMeasure.kmPerH;
  const savedPressureMeasure = PressureMeasure.mmHg;

  test('initialize', () async {
    when(() => storage.load()).thenAnswer((_) async => const PreferencesLoaded(
          initialTemperatureMeasure,
          initialWindMeasure,
          initialPressureMeasure,
        ));

    await repository.initialize();

    expect(
      repository.temperatureMeasure,
      initialTemperatureMeasure,
    );

    expect(
      repository.windMeasure,
      initialWindMeasure,
    );

    expect(
      repository.pressureMeasure,
      initialPressureMeasure,
    );

    verify(() => storage.load()).called(1);
  });

  test('saveTemperatureMeasure', () async {
    when(() => storage.saveTemperatureMeasure(savedTemperatureMeasure))
        .thenAnswer((_) async {});

    await repository.saveTemperatureMeasure(savedTemperatureMeasure);

    expect(
      repository.temperatureMeasure,
      savedTemperatureMeasure,
    );

    verify(() => storage.saveTemperatureMeasure(savedTemperatureMeasure))
        .called(1);
  });

  test('saveWindMeasure', () async {
    when(() => storage.saveWindMeasure(savedWindMeasure))
        .thenAnswer((_) async {});

    await repository.saveWindMeasure(savedWindMeasure);

    expect(
      repository.windMeasure,
      savedWindMeasure,
    );

    verify(() => storage.saveWindMeasure(savedWindMeasure)).called(1);
  });

  test('savePressureMeasure', () async {
    when(() => storage.savePressureMeasure(savedPressureMeasure))
        .thenAnswer((_) async {});

    await repository.savePressureMeasure(savedPressureMeasure);

    expect(
      repository.pressureMeasure,
      savedPressureMeasure,
    );

    verify(() => storage.savePressureMeasure(savedPressureMeasure)).called(1);
  });
}
