import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

import '../../models/weather_measure.dart';
import '../../utils.dart';
import 'scale_fade_animated_switcher.dart';

class WeatherTemperature extends StatelessWidget {
  const WeatherTemperature({
    super.key,
    required int temperature,
    required int temperatureBefore,
    required int temperatureAfter,
    required TemperatureMeasure temperatureMeasure,
  })  : _isPlaceholder = false,
        _temperature = temperature,
        _temperatureBefore = temperatureBefore,
        _temperatureAfter = temperatureAfter,
        _temperatureMeasure = temperatureMeasure;

  const WeatherTemperature.placeholder({super.key})
      : _isPlaceholder = true,
        _temperature = null,
        _temperatureBefore = null,
        _temperatureAfter = null,
        _temperatureMeasure = null;

  final bool _isPlaceholder;

  final int? _temperature;
  final int? _temperatureBefore;
  final int? _temperatureAfter;
  final TemperatureMeasure? _temperatureMeasure;

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholder() {
      return SizedBox(
        height:
            Utils.computeTextHeight(Theme.of(context).textTheme.displayLarge!),
      );
    }

    Widget buildTemperature() {
      final before = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _temperatureBefore! < _temperature!
                ? Icons.south_rounded
                : Icons.north_rounded,
            size: 16,
          ),
          const SizedBox(width: 2),
          Text(
            _temperatureMeasure!.toText(_temperatureBefore!),
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ],
      );

      final now = Text(
        _temperatureMeasure!.toText(_temperature!),
        style: Theme.of(context).textTheme.displayLarge!,
      );

      final after = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _temperatureAfter! < _temperature!
                ? Icons.south_rounded
                : Icons.north_rounded,
            size: 16,
          ),
          const SizedBox(width: 2),
          Text(
            _temperatureMeasure!.toText(_temperatureAfter!),
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ],
      );

      return ScaleFadeAnimatedSwitcher(
        child: Row(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            before,
            now,
            after,
          ],
        ),
      );
    }

    return AnimatedSwitcher(
      duration: AnimationDuration.standard,
      child: _isPlaceholder ? buildPlaceholder() : buildTemperature(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isPlaceholder', _isPlaceholder));
    properties.add(IntProperty('temperature', _temperature));
    properties.add(IntProperty('temperatureBefore', _temperatureBefore));
    properties.add(IntProperty('temperatureAfter', _temperatureAfter));
    properties.add(EnumProperty<TemperatureMeasure>(
        'temperatureMeasure', _temperatureMeasure));
  }
}
