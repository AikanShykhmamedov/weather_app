import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../../../models/weather_measure.dart';

typedef OnValueChanged<T> = void Function(T);

/// {@template settings_sliver}
/// A sliver with user preferences.
/// {@endtemplate}
class SettingsSliver extends StatelessWidget {
  /// {@macro settings_sliver}
  const SettingsSliver({
    super.key,
    required this.temperature,
    required this.wind,
    required this.pressure,
    required this.onTemperatureChanged,
    required this.onWindChanged,
    required this.onPressureChanged,
  });

  final TemperatureMeasure temperature;
  final WindMeasure wind;
  final PressureMeasure pressure;

  final OnValueChanged<TemperatureMeasure> onTemperatureChanged;
  final OnValueChanged<WindMeasure> onWindChanged;
  final OnValueChanged<PressureMeasure> onPressureChanged;

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(height: 16);

    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        _Toggle<TemperatureMeasure>(
          value: temperature,
          values: TemperatureMeasure.values,
          labels: TemperatureMeasure.values
              .map<String>(S.of(context).temperature_measure)
              .toList(),
          onValueChanged: onTemperatureChanged,
        ),
        spacing,
        _Toggle<WindMeasure>(
          value: wind,
          values: WindMeasure.values,
          labels: WindMeasure.values
              .map<String>(S.of(context).wind_measure)
              .toList(),
          onValueChanged: onWindChanged,
        ),
        spacing,
        _Toggle<PressureMeasure>(
          value: pressure,
          values: PressureMeasure.values,
          labels: PressureMeasure.values
              .map<String>(S.of(context).pressure_measure)
              .toList(),
          onValueChanged: onPressureChanged,
        ),
      ]),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(EnumProperty<TemperatureMeasure>('temperature', temperature));
    properties.add(EnumProperty<WindMeasure>('wind', wind));
    properties.add(EnumProperty<PressureMeasure>('pressure', pressure));
  }
}

class _Toggle<T> extends StatelessWidget {
  const _Toggle({
    super.key,
    required this.value,
    required this.values,
    required this.labels,
    required this.onValueChanged,
  });

  final T value;
  final List<T> values;
  final List<String> labels;
  final OnValueChanged<T> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: List.generate(
          max(0, values.length * 2 - 1),
          (i) {
            if (i % 2 == 1) {
              return const SizedBox(width: 16);
            }

            i ~/= 2;

            return Expanded(
              child: TextButton(
                onPressed: () => _onItemPressed(values[i]),
                style: TextButton.styleFrom(
                  backgroundColor: value == values[i]
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.background,
                  animationDuration: AnimationDuration.standard,
                ),
                child: Text(labels[i]),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onItemPressed(T newValue) {
    if (value != newValue) {
      onValueChanged(newValue);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<T>('value', value));
    properties.add(IterableProperty<T>('values', values));
    properties.add(IterableProperty<String>('labels', labels));
  }
}
