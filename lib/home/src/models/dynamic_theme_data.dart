import 'package:flutter/material.dart';

import '../constants/weather_colors.dart';
import '../utils.dart';
import 'city_weather.dart';

/// {@template dynamic_theme_data}
/// A class containing theme specifications.
/// {@endtemplate}
class DynamicThemeData {
  /// {@macro dynamic_theme_data}
  const DynamicThemeData({
    required this.brightness,
    required this.background,
    required this.onBackground,
  });

  /// Brightness of the App.
  final Brightness brightness;

  /// The background color.
  ///
  /// For example, the scaffold background color.
  final Color background;

  /// The active color.
  ///
  /// For example, button, textFields colors.
  final Color onBackground;

  /// Creates a dynamic theme based on the current weather and time.
  factory DynamicThemeData.from(CityWeather cityWeather) {
    switch (cityWeather.type) {
      case WeatherType.clear:
      case WeatherType.fewClouds:
      case WeatherType.clouds:
        final isNowDay = Utils.isNowDay(
          cityWeather.sunrise,
          cityWeather.sunset,
          cityWeather.timeZone,
        );

        if (isNowDay) {
          return const DynamicThemeData(
            brightness: Brightness.light,
            background: WeatherColors.lightBackground,
            onBackground: WeatherColors.lightOnBackground,
          );
        } else {
          return const DynamicThemeData(
            brightness: Brightness.dark,
            background: WeatherColors.darkBackground,
            onBackground: WeatherColors.darkOnBackground,
          );
        }
      case WeatherType.rain:
      case WeatherType.heavyRain:
      case WeatherType.snow:
      case WeatherType.thunderstorm:
        return const DynamicThemeData(
          brightness: Brightness.light,
          background: WeatherColors.grayBackground,
          onBackground: WeatherColors.grayOnBackground,
        );
    }
  }

  /// Linearly interpolates between two dynamic themes.
  static DynamicThemeData lerp(
    DynamicThemeData a,
    DynamicThemeData b,
    double t,
  ) {
    return DynamicThemeData(
      brightness: t <= 0.5 ? a.brightness : b.brightness,
      background: Color.lerp(a.background, b.background, t)!,
      onBackground: Color.lerp(a.onBackground, b.onBackground, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        (other is DynamicThemeData &&
            other.brightness == brightness &&
            other.background == background &&
            other.onBackground == onBackground);
  }

  @override
  int get hashCode {
    return Object.hash(brightness, background, onBackground);
  }
}
