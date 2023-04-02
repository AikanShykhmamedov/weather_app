import 'dart:math';

import 'package:timezone/timezone.dart' as tz;
import 'package:weather_api/weather_api.dart';

/// All possible types of weather in the App.
enum WeatherType {
  clear,
  fewClouds,
  clouds,
  rain,
  heavyRain,
  snow,
  thunderstorm;
}

/// {@template city_weather}
/// Current weather of the city.
/// {@endtemplate}
class CityWeather {
  /// {@macro city_weather}
  const CityWeather({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.timeZone,
    required this.type,
    required this.temperature,
    required this.temperatureBefore,
    required this.temperatureAfter,
    required this.sunrise,
    required this.sunset,
    required this.wind,
    required this.pressure,
  });

  /// Latitude of the city.
  final double latitude;

  /// Longitude of the city.
  final double longitude;

  /// Name of the city.
  final String name;

  /// Timezone of the city.
  final tz.Location timeZone;

  /// Current weather type.
  final WeatherType type;

  /// Current temperature in Celsius.
  final int temperature;

  /// Temperature 3 hours ago in Celsius.
  final int temperatureBefore;

  /// Temperature 3 hours after in Celsius.
  final int temperatureAfter;

  /// Time of sunrise.
  final DateTime sunrise;

  /// Time of sunset.
  final DateTime sunset;

  /// Wind speed in km/h.
  final double wind;

  /// Pressure in hPa.
  final int pressure;

  factory CityWeather.fromForecast(Forecast forecast) {
    return CityWeather(
      latitude: forecast.location.lat,
      longitude: forecast.location.lon,
      name: forecast.location.name,
      timeZone: tz.getLocation(forecast.location.tzId!),
      type: _resolveWeatherType(forecast.current.conditionCode),
      temperature: forecast.current.tempC.round(),
      temperatureBefore:
          _resolveTemperatureBefore(forecast.forecastDay.hourlyTemperature),
      temperatureAfter:
          _resolveTemperatureAfter(forecast.forecastDay.hourlyTemperature),
      sunrise: forecast.forecastDay.sunrise,
      sunset: forecast.forecastDay.sunset,
      wind: forecast.current.windKph,
      pressure: forecast.current.pressureMb.round(),
    );
  }

  CityWeather.fromJson(Map<String, dynamic> data)
      : latitude = (data['latitude'] as num).toDouble(),
        longitude = (data['longitude'] as num).toDouble(),
        name = data['name'] as String,
        timeZone = tz.getLocation(data['time_zone'] as String),
        type = WeatherType.values.byName(data['type'] as String),
        temperature = data['temperature'] as int,
        temperatureBefore = data['temperature_before'] as int,
        temperatureAfter = data['temperature_after'] as int,
        sunrise = DateTime.fromMillisecondsSinceEpoch(data['sunrise'] as int),
        sunset = DateTime.fromMillisecondsSinceEpoch(data['sunset'] as int),
        wind = (data['wind'] as num).toDouble(),
        pressure = data['pressure'] as int;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
        'time_zone': timeZone.name,
        'type': type.name,
        'temperature': temperature,
        'temperature_before': temperatureBefore,
        'temperature_after': temperatureAfter,
        'sunrise': sunrise.millisecondsSinceEpoch,
        'sunset': sunset.millisecondsSinceEpoch,
        'wind': wind,
        'pressure': pressure,
      };

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        (other is CityWeather &&
            other.latitude == latitude &&
            other.longitude == longitude &&
            other.name == name &&
            other.timeZone == timeZone &&
            other.type == type &&
            other.temperature == temperature &&
            other.temperatureBefore == temperatureBefore &&
            other.temperatureAfter == temperatureAfter &&
            other.sunrise == sunrise &&
            other.sunset == sunset &&
            other.wind == wind &&
            other.pressure == pressure);
  }

  @override
  int get hashCode {
    return Object.hash(latitude, longitude, name, timeZone, type, temperature,
        temperatureBefore, temperatureAfter, sunrise, sunset, wind, pressure);
  }

  @override
  String toString() {
    return 'CityWeather($name)';
  }

  /// WeatherType codes from WeatherApi.
  ///
  /// [See codes](https://www.weatherapi.com/docs/weather_conditions.json).
  static WeatherType _resolveWeatherType(int code) {
    switch (code) {
      case 1000: // Sunny/Clear,
        return WeatherType.clear;
      case 1003: // Partly cloudy
        return WeatherType.fewClouds;
      case 1006: // Cloudy
      case 1009: // Overcast
      case 1030: // Mist
      case 1063: // Patchy rain possible
      case 1066: // Patchy snow possible
      case 1069: // Patchy sleet possible
      case 1072: // Patchy freezing drizzle possible
      case 1087: // Thundery outbreaks possible
      case 1135: // Fog
      case 1147: // Freezing fog
        return WeatherType.clouds;
      case 1150: // Patchy light drizzle
      case 1153: // Light drizzle
      case 1168: // Freezing drizzle
      case 1180: // Patchy light rain
      case 1183: // Light rain
      case 1186: // Moderate rain at times
      case 1189: // Moderate rain
      case 1198: // Light freezing rain
      case 1240: // Light rain shower
        return WeatherType.rain;
      case 1171: // Heavy freezing drizzle
      case 1192: // Heavy rains at times
      case 1195: // Heavy rains
      case 1201: // Moderate or heavy freezing rain
      case 1243: // Moderate or heavy rain shower
      case 1246: // Torrential rain shower
        return WeatherType.heavyRain;
      case 1114: // Blowing snow
      case 1117: // Blizzard
      case 1204: // Light sleet
      case 1207: // Moderate or heavy sleet
      case 1210: // Patchy light snow
      case 1213: // Light snow
      case 1216: // Patchy moderate snow
      case 1219: // Moderate snow
      case 1222: // Patchy heavy snow
      case 1225: // Heavy snow
      case 1237: // Ice pellets
      case 1249: // Light sleet showers
      case 1252: // Moderate or heavy sleet showers
      case 1255: // Light snow showers
      case 1258: // Moderate or heavy snow showers
      case 1261: // Light showers of ice pellets
      case 1264: // Moderate or heavy showers of ice pellets
        return WeatherType.snow;
      case 1273: // Patchy light rain with thunder
      case 1276: // Moderate or heavy rain with thunder
      case 1279: // Patchy light snow with thunder
      case 1282: // Moderate or heavy snow with thunder
        return WeatherType.thunderstorm;
      default:
        return WeatherType.clear;
    }
  }

  /// Returns temperature 3 hours ago.
  ///
  /// If we cannot get get the temperature that time, then we estimate it with
  /// linear interpolation.
  static int _resolveTemperatureBefore(List<double> hourlyTemperature) {
    final hour = _getHourRounded();

    if (hour >= 3) {
      return hourlyTemperature[hour - 3].round();
    } else {
      const x1 = 0;
      final x2 = max(1, hour);

      final line = _getLine(
        x1,
        x2,
        hourlyTemperature[x1],
        hourlyTemperature[x2],
      );

      return line(hour - 3).round();
    }
  }

  /// Returns temperature in 3 hours.
  ///
  /// If we cannot get get the temperature that time, then we estimate it with
  /// linear interpolation.
  static int _resolveTemperatureAfter(List<double> hourlyTemperature) {
    final hour = _getHourRounded();

    if (hour <= 20) {
      return hourlyTemperature[hour + 3].round();
    } else {
      final x1 = min(22, hour);
      const x2 = 23;

      final line = _getLine(
        x1,
        x2,
        hourlyTemperature[x1],
        hourlyTemperature[x2],
      );

      return line(hour + 3).round();
    }
  }

  /// Returns rounded current time.
  ///
  /// For example, 7:40 is 8 hours rounded.
  static int _getHourRounded() {
    final now = DateTime.now();

    return now.hour + (now.minute / 60).round();
  }

  /// Constructs a line through given points `(x1, y1)` and `(x2, y2)`.
  ///
  /// Returns a function that can compute `y` for a given `x` on this line.
  static double Function(int x) _getLine(
    int x1,
    int x2,
    double y1,
    double y2,
  ) {
    final k = (y2 - y1) / (x2 - x1);

    return (x) => k * (x - x1) + y1;
  }
}
