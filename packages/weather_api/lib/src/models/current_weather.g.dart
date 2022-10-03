// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      (json['temp_c'] as num).toDouble(),
      CurrentWeather._extractConditionCode(
          json['condition'] as Map<String, dynamic>),
      (json['wind_kph'] as num).toDouble(),
      (json['pressure_mb'] as num).toDouble(),
    );
