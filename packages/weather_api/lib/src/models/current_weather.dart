import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_weather.g.dart';

/// {@template current_weather}
/// Current weather conditions.
/// {@endtemplate}
@JsonSerializable()
class CurrentWeather extends Equatable {
  /// {@macro current_weather}
  const CurrentWeather(
    this.tempC,
    this.conditionCode,
    this.windKph,
    this.pressureMb,
  );

  /// Temperature in Celsius.
  final double tempC;

  @JsonKey(name: 'condition', fromJson: _extractConditionCode)
  final int conditionCode;

  /// Wind speed in km/h.
  final double windKph;

  /// Pressure in millibar.
  final double pressureMb;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  static int _extractConditionCode(Map<String, dynamic> json) {
    return json['code'] as int;
  }

  @override
  List<Object> get props => [tempC, conditionCode, windKph, pressureMb];

  @override
  bool get stringify => true;
}
