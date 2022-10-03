import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/home/src/models/weather_measure.dart';
import 'package:weather_app/home/src/providers/preferences.dart';
import 'package:weather_app/home/src/repositories/preferences_repository.dart';

class MockPreferencesRepository extends Mock implements PreferencesRepository {}

void main() async {
  final repository = MockPreferencesRepository();
  final preferences = Preferences(repository: repository);

  const initialTemperatureMeasure = TemperatureMeasure.celsius;
  const initialWindMeasure = WindMeasure.mPerS;
  const initialPressureMeasure = PressureMeasure.hPa;

  const setTemperatureMeasure = TemperatureMeasure.fahrenheit;
  const setWindMeasure = WindMeasure.kmPerH;
  const setPressureMeasure = PressureMeasure.mmHg;

  test('initialize', () async {
    when(() => repository.initialize()).thenAnswer((_) async {});
    when(() => repository.temperatureMeasure)
        .thenReturn(initialTemperatureMeasure);
    when(() => repository.windMeasure).thenReturn(initialWindMeasure);
    when(() => repository.pressureMeasure).thenReturn(initialPressureMeasure);

    await preferences.initialize();

    expect(
      preferences.temperatureMeasure,
      initialTemperatureMeasure,
    );

    expect(
      preferences.windMeasure,
      initialWindMeasure,
    );

    expect(
      preferences.pressureMeasure,
      initialPressureMeasure,
    );

    verify(() => repository.initialize()).called(1);
  });

  test('setTemperatureMeasure', () async {
    when(() => repository.saveTemperatureMeasure(setTemperatureMeasure))
        .thenAnswer((_) async {});

    await preferences.setTemperatureMeasure(setTemperatureMeasure);

    expect(
      preferences.temperatureMeasure,
      setTemperatureMeasure,
    );

    verify(() => repository.saveTemperatureMeasure(setTemperatureMeasure))
        .called(1);
  });

  test('setWindMeasure', () async {
    when(() => repository.saveWindMeasure(setWindMeasure))
        .thenAnswer((_) async {});

    await preferences.setWindMeasure(setWindMeasure);

    expect(
      preferences.windMeasure,
      setWindMeasure,
    );

    verify(() => repository.saveWindMeasure(setWindMeasure)).called(1);
  });

  test('setPressureMeasure', () async {
    when(() => repository.savePressureMeasure(setPressureMeasure))
        .thenAnswer((_) async {});

    await preferences.setPressureMeasure(setPressureMeasure);

    expect(
      preferences.pressureMeasure,
      setPressureMeasure,
    );

    verify(() => repository.savePressureMeasure(setPressureMeasure)).called(1);
  });
}
