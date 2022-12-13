import 'package:flutter/material.dart';

import '../../constants/weather_animation_artboards.dart';
import '../../models/city_weather.dart';
import 'location_unavailable.dart';
import 'weather_animation.dart';

class LocalAreaPage extends StatelessWidget {
  const LocalAreaPage({
    super.key,
    required this.isServiceEnabled,
    required this.isPermissionGranted,
    required this.openLocationSettings,
    required this.openAppSettings,
    required this.city,
  });

  final bool isServiceEnabled;
  final bool isPermissionGranted;
  final Future<void> Function() openLocationSettings;
  final Future<void> Function() openAppSettings;
  final CityWeather? city;

  @override
  Widget build(BuildContext context) {
    if (!isServiceEnabled) {
      return LocationServiceUnavailable(
        openSettings: openLocationSettings,
      );
    } else if (!isPermissionGranted) {
      return PermissionNotGranted(
        openAppSettings: openAppSettings,
      );
    }

    if (city == null) {
      // TODO: What if we can't load the local city
      // due to connection problems. Then indicator
      // will run forever. Maybe we need to show some
      // error message in that case.
      return const Center(
        child: SizedBox.square(
          dimension: 32,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      );
    }

    final artboard = WeatherAnimationArtboards.resolve(city!);

    return WeatherAnimation(
      artboard: artboard,
    );
  }
}
