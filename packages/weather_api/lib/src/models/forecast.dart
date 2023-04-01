import 'package:equatable/equatable.dart';

import 'current_weather.dart';
import 'forecast_day.dart';
import 'location.dart';

/// {@template forecast}
/// Weather for today.
/// {@endtemplate}
class Forecast extends Equatable {
  /// {@macro forecast}
  const Forecast(
    this.location,
    this.current,
    this.forecastDay,
  );

  /// {@macro location}
  final Location location;

  /// {@macro current_weather}
  final CurrentWeather current;

  /// {@macro forecast_day}
  final ForecastDay forecastDay;

  factory Forecast.fromJson(Map<String, dynamic> data) {
    final location =
        Location.fromJson(data['location'] as Map<String, dynamic>);
    final current =
        CurrentWeather.fromJson(data['current'] as Map<String, dynamic>);
    final forecastDay = ForecastDay.fromJson(
        data['forecast']['forecastday'][0] as Map<String, dynamic>);

    return Forecast(location, current, forecastDay);
  }

  @override
  List<Object> get props => [location, current, forecastDay];

  @override
  bool get stringify => true;
}
