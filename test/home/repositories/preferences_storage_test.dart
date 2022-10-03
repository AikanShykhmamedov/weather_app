import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/home/src/models/weather_measure.dart';
import 'package:weather_app/home/src/repositories/preferences_storage.dart';

void main() {
  const storage = PreferencesStorage();

  group('load', () {
    test('Without cache', () async {
      SharedPreferences.setMockInitialValues({});

      final loaded = await storage.load();

      expect(loaded.temperatureMeasure, defaultTemperatureMeasure);
      expect(loaded.windMeasure, defaultWindMeasure);
      expect(loaded.pressureMeasure, defaultPressureMeasure);
    });

    test('With cache', () async {
      const expectedTemperatureMeasure = TemperatureMeasure.celsius;
      const expectedWindMeasure = WindMeasure.mPerS;
      const expectedPressureMeasure = PressureMeasure.mmHg;

      SharedPreferences.setMockInitialValues({
        PreferencesStorage.temperatureMeasureKey:
            expectedTemperatureMeasure.name,
        PreferencesStorage.windMeasureKey: expectedWindMeasure.name,
        PreferencesStorage.pressureMeasureKey: expectedPressureMeasure.name,
      });

      final loaded = await storage.load();

      expect(loaded.temperatureMeasure, expectedTemperatureMeasure);
      expect(loaded.windMeasure, expectedWindMeasure);
      expect(loaded.pressureMeasure, expectedPressureMeasure);
    });
  });

  group('save[Temperature|Wind|Pressure]Measure', () {
    late final SharedPreferences prefs;

    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('Temperature', () async {
      const expected = TemperatureMeasure.fahrenheit;

      await storage.saveTemperatureMeasure(expected);

      expect(
        prefs.getString(PreferencesStorage.temperatureMeasureKey),
        expected.name,
      );
    });

    test('Wind', () async {
      const expected = WindMeasure.kmPerH;

      await storage.saveWindMeasure(expected);

      expect(
        prefs.getString(PreferencesStorage.windMeasureKey),
        expected.name,
      );
    });

    test('Pressure', () async {
      const expected = PressureMeasure.mmHg;

      await storage.savePressureMeasure(expected);

      expect(
        prefs.getString(PreferencesStorage.pressureMeasureKey),
        expected.name,
      );
    });
  });
}

final defaultTemperatureMeasure = TemperatureMeasure.byName(null);
final defaultWindMeasure = WindMeasure.byName(null);
final defaultPressureMeasure = PressureMeasure.byName(null);
