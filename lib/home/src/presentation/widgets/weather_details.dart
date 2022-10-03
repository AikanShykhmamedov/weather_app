import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/app_constants.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../../models/weather_measure.dart';
import '../../utils.dart';
import 'scale_fade_animated_switcher.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
    required DateTime sunrise,
    required DateTime sunset,
    required double wind,
    required int pressure,
    required WindMeasure windMeasure,
    required PressureMeasure pressureMeasure,
    this.verticalSpacing = 8.0,
  })  : _isPlaceholder = false,
        _sunrise = sunrise,
        _sunset = sunset,
        _wind = wind,
        _pressure = pressure,
        _windMeasure = windMeasure,
        _pressureMeasure = pressureMeasure;

  const WeatherDetails.placeholder({
    super.key,
    this.verticalSpacing = 8.0,
  })  : _isPlaceholder = true,
        _sunrise = null,
        _sunset = null,
        _wind = null,
        _pressure = null,
        _windMeasure = null,
        _pressureMeasure = null;

  final bool _isPlaceholder;

  final DateTime? _sunrise;
  final DateTime? _sunset;
  final double? _wind;
  final int? _pressure;
  final WindMeasure? _windMeasure;
  final PressureMeasure? _pressureMeasure;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholder() {
      return Column(
        key: UniqueKey(),
        children: [
          SizedBox(
            height: _AnimatedItem.computeHeight(context) * 2 + verticalSpacing,
          )
        ],
      );
    }

    Widget buildDetails() {
      final dateFormat = DateFormat.Hm();

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _AnimatedItem(
                title: S.of(context).sunrise.toUpperCase(),
                text: dateFormat.format(_sunrise!),
              ),
              const Spacer(),
              _AnimatedItem(
                title: S.of(context).sunset.toUpperCase(),
                text: dateFormat.format(_sunset!),
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          SizedBox(height: verticalSpacing),
          Row(
            children: [
              _AnimatedItem(
                title: S.of(context).wind.toUpperCase(),
                text: _windMeasure!.toText(
                  _wind!,
                  S.of(context).wind_measure,
                ),
              ),
              const Spacer(),
              _AnimatedItem(
                title: S.of(context).pressure.toUpperCase(),
                text: _pressureMeasure!
                    .toText(_pressure!, S.of(context).pressure_measure),
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      );
    }

    return AnimatedSwitcher(
      duration: AnimationDuration.standard,
      child: _isPlaceholder ? buildPlaceholder() : buildDetails(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isPlaceholder', _isPlaceholder));
    properties.add(StringProperty('sunrise', _sunrise?.toString()));
    properties.add(StringProperty('sunset', _sunset?.toString()));
    properties.add(DoubleProperty('wind', _wind));
    properties.add(IntProperty('pressure', _pressure));
    properties.add(EnumProperty<WindMeasure>('windMeasure', _windMeasure));
    properties.add(
        EnumProperty<PressureMeasure>('pressureMeasure', _pressureMeasure));
    properties.add(DoubleProperty('verticalSpacing', verticalSpacing));
  }
}

class _AnimatedItem extends StatelessWidget {
  const _AnimatedItem({
    required this.title,
    required this.text,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;

  static const _verticalSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!,
        ),
        const SizedBox(height: _verticalSpacing),
        ScaleFadeAnimatedSwitcher(
          alignment: crossAxisAlignment == CrossAxisAlignment.start
              ? Alignment.centerLeft
              : Alignment.centerRight,
          startScale: 0.75,
          child: Text(
            key: UniqueKey(),
            text,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
        ),
      ],
    );
  }

  static double computeHeight(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleHeight = Utils.computeTextHeight(textTheme.titleSmall!);
    final textHeight = Utils.computeTextHeight(textTheme.titleLarge!);

    return titleHeight + _verticalSpacing + textHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('text', text));
    properties.add(EnumProperty<CrossAxisAlignment>(
        'crossAxisAlignment', crossAxisAlignment));
  }
}
