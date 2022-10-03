import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_measure.dart';

class PreferencesLoaded {
  const PreferencesLoaded(
    this.temperatureMeasure,
    this.windMeasure,
    this.pressureMeasure,
  );

  final TemperatureMeasure temperatureMeasure;
  final WindMeasure windMeasure;
  final PressureMeasure pressureMeasure;
}

/// {@template preferences_storage}
/// Manages preferences in SharedPreferences store.
/// {@endtemplate}
class PreferencesStorage {
  /// {@macro preferences_storage}
  const PreferencesStorage();

  static const temperatureMeasureKey = 'temperature_measure';
  static const windMeasureKey = 'wind_measure';
  static const pressureMeasureKey = 'pressure_measure';

  /// Loads preferences from cache.
  Future<PreferencesLoaded> load() async {
    final prefs = await SharedPreferences.getInstance();

    final temperatureMeasure = TemperatureMeasure.byName(
      prefs.getString(temperatureMeasureKey),
    );
    final windMeasure = WindMeasure.byName(
      prefs.getString(windMeasureKey),
    );
    final pressureMeasure = PressureMeasure.byName(
      prefs.getString(pressureMeasureKey),
    );

    return PreferencesLoaded(
      temperatureMeasure,
      windMeasure,
      pressureMeasure,
    );
  }

  /// Saves temperature measure to cache.
  Future<void> saveTemperatureMeasure(TemperatureMeasure measure) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(temperatureMeasureKey, measure.name);
  }

  /// Saves wind measure to cache.
  Future<void> saveWindMeasure(WindMeasure measure) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(windMeasureKey, measure.name);
  }

  /// Saves pressure measure to cache.
  Future<void> savePressureMeasure(PressureMeasure measure) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pressureMeasureKey, measure.name);
  }
}
