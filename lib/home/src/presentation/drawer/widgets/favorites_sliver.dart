import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../../../models/city_weather.dart';
import '../../../models/weather_measure.dart';
import 'dismissible_city_item.dart';

/// {@template favorites_sliver}
/// A sliver with user favorite cities.
/// {@endtemplate}
class FavoritesSliver extends StatelessWidget {
  /// {@macro favorites_sliver}
  const FavoritesSliver({
    super.key,
    required this.favoriteCities,
    required this.temperatureMeasure,
    required this.onCityPressed,
    required this.onCityRemoved,
  });

  final List<CityWeather> favoriteCities;
  final TemperatureMeasure temperatureMeasure;
  final void Function(int) onCityPressed;
  final void Function(CityWeather) onCityRemoved;

  @override
  Widget build(BuildContext context) {
    if (favoriteCities.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Center(
            child: Text(
              S.of(context).drawer_add_cities,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: max(0, favoriteCities.length * 2 - 1),
        (context, index) {
          if (index % 2 == 1) {
            return const SizedBox(height: 8);
          }

          index ~/= 2;

          final city = favoriteCities[index];

          return DismissibleCityItem(
            key: ObjectKey(city),
            name: city.name,
            temperature: temperatureMeasure.toText(city.temperature),
            onPressed: () => onCityPressed(index),
            onRemoved: () => onCityRemoved(city),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<CityWeather>('favoriteCities', favoriteCities));
    properties.add(EnumProperty<TemperatureMeasure>(
        'temperatureMeasure', temperatureMeasure));
  }
}
