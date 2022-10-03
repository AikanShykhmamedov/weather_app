import 'dart:async';

import 'package:flutter/material.dart';

import '../models/weather_measure.dart';
import '../repositories/preferences_repository.dart';

/// {@template preferences}
/// A class responsible for user preferences.
/// {@endtemplate}
class Preferences extends ChangeNotifier {
  /// {@macro preferences}
  Preferences({
    PreferencesRepository? repository,
  }) : _repository = repository ?? PreferencesRepository();

  final PreferencesRepository _repository;

  /// Current temperature measure.
  TemperatureMeasure get temperatureMeasure => _temperatureMeasure;
  late TemperatureMeasure _temperatureMeasure;

  /// Current wind speed measure.
  WindMeasure get windMeasure => _windMeasure;
  late WindMeasure _windMeasure;

  /// Current pressure measure.
  PressureMeasure get pressureMeasure => _pressureMeasure;
  late PressureMeasure _pressureMeasure;

  /// Loads user preferences.
  Future<void> initialize() async {
    await _repository.initialize();

    _temperatureMeasure = _repository.temperatureMeasure;
    _windMeasure = _repository.windMeasure;
    _pressureMeasure = _repository.pressureMeasure;

    notifyListeners();
  }

  /// Sets temperature measure and saves it to cache.
  Future<void> setTemperatureMeasure(TemperatureMeasure measure) async {
    if (_temperatureMeasure != measure) {
      _temperatureMeasure = measure;
      notifyListeners();
      await _repository.saveTemperatureMeasure(measure);
    }
  }

  /// Sets wind measure and saves it to cache.
  Future<void> setWindMeasure(WindMeasure measure) async {
    if (_windMeasure != measure) {
      _windMeasure = measure;
      notifyListeners();
      await _repository.saveWindMeasure(measure);
    }
  }

  /// Sets pressure measure and saves it to cache.
  Future<void> setPressureMeasure(PressureMeasure measure) async {
    if (_temperatureMeasure != measure) {
      _pressureMeasure = measure;
      notifyListeners();
      await _repository.savePressureMeasure(measure);
    }
  }
}
