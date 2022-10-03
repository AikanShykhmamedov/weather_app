import 'package:flutter/material.dart';

import '../constants/weather_colors.dart';
import '../models/city_weather.dart';
import '../models/dynamic_theme_data.dart';

/// {@template dynamic_theme}
/// A class responsible for dynamic theming.
/// {@endtemplate}
class DynamicTheme extends ChangeNotifier {
  /// {@macro dynamic_theme}
  DynamicTheme()
      : _themeData = _defaultTheme,
        _continuousThemeData = _defaultTheme;

  /// Current theme data.
  DynamicThemeData get themeData => _themeData;
  DynamicThemeData _themeData;

  /// Transitioning theme data.
  ///
  /// This theme changes when a user slides between pages. It gives effect
  /// of continuous theme change.
  DynamicThemeData get continuousThemeData => _continuousThemeData;
  DynamicThemeData _continuousThemeData;

  static const _defaultTheme = DynamicThemeData(
    brightness: Brightness.light,
    background: WeatherColors.lightBackground,
    onBackground: WeatherColors.lightOnBackground,
  );

  /// Sets theme data based on this `city`.
  ///
  /// If `city` is null keeps the theme the same, i.e. does nothing.
  void set(CityWeather? city) {
    if (city != null) {
      final themeData = DynamicThemeData.from(city);

      if (_themeData != themeData) {
        _themeData = themeData;
        _continuousThemeData = themeData;
        notifyListeners();
      }
    }
  }

  /// Linearly interpolates between two dynamic themes.
  void lerp(CityWeather? a, CityWeather? b, double t) {
    if (a == null || b == null) {
      return;
    }

    final themeDataA = DynamicThemeData.from(a);
    final themeDataB = DynamicThemeData.from(b);

    _themeData = t < 0.5 ? themeDataA : themeDataB;
    _continuousThemeData = DynamicThemeData.lerp(themeDataA, themeDataB, t);

    notifyListeners();
  }
}
