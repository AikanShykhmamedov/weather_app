import 'dart:async';

import 'package:weather_app/home/src/repositories/preferences_storage.dart';

import '../models/weather_measure.dart';

/// {@template preferences_repository}
/// A repository responsible for managing user preferences.
/// {@endtemplate}
class PreferencesRepository {
  /// {@macro preferences_repository}
  PreferencesRepository({
    PreferencesStorage? storage,
  }) : _storage = storage ?? const PreferencesStorage();

  final PreferencesStorage _storage;

  TemperatureMeasure get temperatureMeasure => _temperatureMeasure;
  late TemperatureMeasure _temperatureMeasure;

  WindMeasure get windMeasure => _windMeasure;
  late WindMeasure _windMeasure;

  PressureMeasure get pressureMeasure => _pressureMeasure;
  late PressureMeasure _pressureMeasure;

  /// Loads preferences from cache.
  Future<void> initialize() async {
    final loaded = await _storage.load();

    _temperatureMeasure = loaded.temperatureMeasure;
    _windMeasure = loaded.windMeasure;
    _pressureMeasure = loaded.pressureMeasure;
  }

  /// Saves temperature measure to cache.
  Future<void> saveTemperatureMeasure(TemperatureMeasure measure) async {
    if (_temperatureMeasure != measure) {
      _temperatureMeasure = measure;
      await _storage.saveTemperatureMeasure(measure);
    }
  }

  /// Saves wind measure to cache.
  Future<void> saveWindMeasure(WindMeasure measure) async {
    if (_windMeasure != measure) {
      _windMeasure = measure;
      await _storage.saveWindMeasure(measure);
    }
  }

  /// Saves pressure measure to cache.
  Future<void> savePressureMeasure(PressureMeasure measure) async {
    if (_pressureMeasure != measure) {
      _pressureMeasure = measure;
      await _storage.savePressureMeasure(measure);
    }
  }
}
