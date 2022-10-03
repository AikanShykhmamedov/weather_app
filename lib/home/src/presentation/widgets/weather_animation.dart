import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:weather_app/app/app_constants.dart';

class WeatherAnimation extends StatelessWidget {
  const WeatherAnimation({
    super.key,
    required this.artboard,
  });

  final String artboard;

  @override
  Widget build(BuildContext context) {
    // TODO: Rive do not change artboard on configuration update.
    // RiveAnimation need to be disposed first.
    return RiveAnimation.asset(
      Assets.weatherAnimation,
      artboard: artboard,
      animations: const ['running'],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('artboard', artboard));
  }
}
