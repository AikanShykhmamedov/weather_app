import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// {@template forecast_day}
/// Day related weather information.
/// {@endtemplate}
class ForecastDay extends Equatable {
  /// {@macro forecast_day}
  const ForecastDay(
    this.sunrise,
    this.sunset,
    this.hourlyTemperature,
  );

  final DateTime sunrise;
  final DateTime sunset;

  /// Hourly temperature in Celsius between 0-24 (i.e. 24 entries).
  final List<double> hourlyTemperature;

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final astro = json['astro'] as Map;

    final dateFormat = DateFormat('hh:mm aa');
    final sunrise = dateFormat.parse(astro['sunrise'], true);
    final sunset = dateFormat.parse(astro['sunset'], true);

    final hour = json['hour'] as List;
    final hourlyTemperature =
        hour.map<double>((e) => (e['temp_c'] as num).toDouble()).toList();

    return ForecastDay(sunrise, sunset, hourlyTemperature);
  }

  @override
  List<Object> get props => [sunrise, sunset, hourlyTemperature];

  @override
  bool get stringify => true;
}
