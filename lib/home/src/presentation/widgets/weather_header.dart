import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';
import 'package:weather_app/localization/localization.dart';

import '../../models/city_weather.dart';
import '../../utils.dart';
import 'scale_fade_animated_switcher.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({
    super.key,
    required String cityName,
    required WeatherType weatherType,
    this.verticalSpacing = 4.0,
  })  : _isPlaceholder = false,
        _cityName = cityName,
        _weatherType = weatherType;

  const WeatherHeader.placeholder({
    super.key,
    this.verticalSpacing = 4.0,
  })  : _isPlaceholder = true,
        _cityName = null,
        _weatherType = null;

  final bool _isPlaceholder;

  final String? _cityName;
  final WeatherType? _weatherType;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholder() {
      final cityNameHeight =
          Utils.computeTextHeight(Theme.of(context).textTheme.headlineLarge!);
      final weatherTypeHeight =
          Utils.computeTextHeight(Theme.of(context).textTheme.titleMedium!);

      return SizedBox(
        height: cityNameHeight + verticalSpacing + weatherTypeHeight,
      );
    }

    Widget buildHeader() {
      final cityName = Text(
        _cityName!,
        style: Theme.of(context).textTheme.headlineLarge!,
      );

      final weatherType = Text(
        S.of(context).weather_type(_weatherType!).toLowerCase(),
        style: Theme.of(context).textTheme.titleMedium!,
      );

      return ScaleFadeAnimatedSwitcher(
        startScale: 0.5,
        alignment: Alignment.centerLeft,
        child: Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cityName,
            SizedBox(height: verticalSpacing),
            weatherType,
          ],
        ),
      );
    }

    return AnimatedSwitcher(
      duration: AnimationDuration.standard,
      child: _isPlaceholder ? buildPlaceholder() : buildHeader(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isPlaceholder', _isPlaceholder));
    properties.add(StringProperty('cityName', _cityName));
    properties.add(EnumProperty<WeatherType>('weatherType', _weatherType));
    properties.add(DoubleProperty('verticalSpacing', verticalSpacing));
  }
}
