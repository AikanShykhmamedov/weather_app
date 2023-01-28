import '../models/city_weather.dart';
import '../utils.dart';

/// All artboards contained in the corresponding rive file.
abstract class WeatherAnimationArtboards {
  // Light background
  static const clear = 'clear';
  static const fewClouds = 'few_clouds';
  static const clouds = 'clouds';

  // Gray background
  static const rain = 'rain';
  static const heavyRain = 'heavy_rain';
  static const snow = 'snow';
  static const thunderstorm = 'thunderstorm';

  // Dark background
  static const clearNight = 'clear_night';
  static const fewCloudsNight = 'few_clouds_night';
  static const cloudsNight = 'clouds_night';

  /// Returns an appropriate artboard based on the current weather and time.
  ///
  /// For example, if the weather is clear returns [clear] if it is daytime in
  /// the city and [clearNight] if it is nighttime.
  static String resolve(CityWeather cityWeather) {
    final isNowDay = Utils.isNowDay(
      cityWeather.sunrise,
      cityWeather.sunset,
      cityWeather.timeZone,
    );

    switch (cityWeather.type) {
      case WeatherType.clear:
        return isNowDay ? clear : clearNight;
      case WeatherType.fewClouds:
        return isNowDay ? fewClouds : fewCloudsNight;
      case WeatherType.clouds:
        return isNowDay ? clouds : cloudsNight;
      case WeatherType.rain:
        return rain;
      case WeatherType.heavyRain:
        return heavyRain;
      case WeatherType.snow:
        return snow;
      case WeatherType.thunderstorm:
        return thunderstorm;
    }
  }
}
