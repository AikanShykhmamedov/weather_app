import 'dart:ui';

/// Colors used for dynamic theming.
abstract class WeatherColors {
  // It is used for [clear], [fewClouds], [clouds] weather types in daytime.
  static const lightBackground = Color(0xffBFE6FC);
  static const lightOnBackground = Color(0xff71C1EE);

  // It is used for [rain], [heavyRain], [snow], [thunderstorm] weather types.
  static const grayBackground = Color(0xff869EB3);
  static const grayOnBackground = Color(0xff5983A8);

  // It is used for [clear], [fewClouds], [clouds] weather types in nighttime.
  static const darkBackground = Color(0xff140E22);
  static const darkOnBackground = Color(0xff413264);
}
