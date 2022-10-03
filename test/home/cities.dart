import 'package:timezone/timezone.dart' as tz;
import 'package:weather_api/src/models/current_weather.dart';
import 'package:weather_api/src/models/forecast_day.dart';
import 'package:weather_api/weather_api.dart';

import 'package:weather_app/home/src/models/city_weather.dart';

final london = CityWeather(
  latitude: 51.52,
  longitude: -0.11,
  name: 'London',
  timeZone: tz.getLocation('Europe/London'),
  type: WeatherType.rain,
  temperature: 16,
  temperatureBefore: 20,
  temperatureAfter: 12,
  sunrise: DateTime.fromMillisecondsSinceEpoch(8 * 60 * 60 * 1000),
  sunset: DateTime.fromMillisecondsSinceEpoch(19 * 60 * 60 * 1000),
  wind: 4,
  pressure: 1020,
);

final paris = CityWeather(
  latitude: 48.87,
  longitude: 2.33,
  name: 'Paris',
  timeZone: tz.getLocation('Europe/Paris'),
  type: WeatherType.clear,
  temperature: 29,
  temperatureBefore: 25,
  temperatureAfter: 23,
  sunrise: DateTime.fromMillisecondsSinceEpoch(7 * 60 * 60 * 1000),
  sunset: DateTime.fromMillisecondsSinceEpoch(20 * 60 * 60 * 1000),
  wind: 6,
  pressure: 1023,
);

final madrid = CityWeather(
  latitude: 40.4,
  longitude: -3.68,
  name: 'Madrid',
  timeZone: tz.getLocation('Europe/Madrid'),
  type: WeatherType.fewClouds,
  temperature: 32,
  temperatureBefore: 27,
  temperatureAfter: 23,
  sunrise: DateTime.fromMillisecondsSinceEpoch(8 * 60 * 60 * 1000),
  sunset: DateTime.fromMillisecondsSinceEpoch(21 * 60 * 60 * 1000),
  wind: 5,
  pressure: 1015,
);

final madridForecast = Forecast(
  const Location('Madrid', 'Madrid', 'Spain', 40.4, -3.68, 'Europe/Madrid'),
  const CurrentWeather(23, 1000, 4.0, 1000),
  ForecastDay(
    DateTime.fromMillisecondsSinceEpoch(6 * 60 * 60 * 1000),
    DateTime.fromMillisecondsSinceEpoch(20 * 60 * 60 * 1000),
    List<double>.generate(24, (_) => 25),
  ),
);

final brokenMadridForecast = Forecast(
  const Location('Madrid', 'Madrid', 'Spain', 40.4, -3.68, 'dirdaM/eporuE'),
  const CurrentWeather(23, 1000, 4.0, 1000),
  ForecastDay(
    DateTime.fromMillisecondsSinceEpoch(6 * 60 * 60 * 1000),
    DateTime.fromMillisecondsSinceEpoch(20 * 60 * 60 * 1000),
    List<double>.generate(24, (_) => 25),
  ),
);

final madridFromForecast = CityWeather.fromForecast(madridForecast);
