import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/app_routes.dart';
import 'package:weather_app/city_search/city_search.dart';
import 'package:weather_app/localization/localization.dart';

import '../../models/city_weather.dart';
import '../../providers/preferences.dart';
import '../../providers/weather.dart';
import 'widgets/favorites_sliver.dart';
import 'widgets/settings_sliver.dart';

/// {@template home_drawer}
/// A drawer that contains settings and favorite cities list.
/// {@endtemplate}
class HomeDrawer extends StatelessWidget {
  /// {@macro home_drawer}
  const HomeDrawer({
    super.key,
    required this.onFavoriteCityPressed,
  });

  /// Returns `id` of a pressed city in the favorite cities list.
  final void Function(int) onFavoriteCityPressed;

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final width = MediaQuery.of(context).size.width;

    final settingsHeader = SliverToBoxAdapter(
      child: Text(
        S.of(context).settings.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium!,
      ),
    );

    final settings = Consumer<Preferences>(
      builder: (_, preferences, __) => SettingsSliver(
        temperature: preferences.temperatureMeasure,
        wind: preferences.windMeasure,
        pressure: preferences.pressureMeasure,
        onTemperatureChanged: preferences.setTemperatureMeasure,
        onWindChanged: preferences.setWindMeasure,
        onPressureChanged: preferences.setPressureMeasure,
      ),
    );

    final favoriteHeader = SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.of(context).favorites.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => _onAddFavoriteCityPressed(context),
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
    );

    final favorites = Selector2<Weather, Preferences, Map>(
      selector: (_, weather, preferences) => {
        'favorite_cities': weather.state.favoriteCities,
        'temperature_measure': preferences.temperatureMeasure,
      },
      builder: (context, selected, _) => FavoritesSliver(
        favoriteCities: selected['favorite_cities'],
        temperatureMeasure: selected['temperature_measure'],
        onCityPressed: (id) => _onFavoriteCityPressed(context, id),
        onCityRemoved: (city) => _onFavoriteCityRemoved(context, city),
      ),
    );

    return Material(
      child: Drawer(
        width: width * 0.8,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, paddingTop + 24, 16, 16),
              sliver: settingsHeader,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: settings,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
              sliver: favoriteHeader,
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 16 + bottomPadding),
              sliver: favorites,
            ),
          ],
        ),
      ),
    );
  }

  void _onAddFavoriteCityPressed(BuildContext context) async {
    final result = await Navigator.pushNamed<CitySearchResult?>(
        context, AppRoutes.citySearch);

    if (result != null) {
      context.read<Weather>().addFavorite(result.latitude, result.longitude);
    }
  }

  void _onFavoriteCityPressed(BuildContext context, int id) {
    onFavoriteCityPressed(id);
    Navigator.pop(context);
  }

  void _onFavoriteCityRemoved(BuildContext context, CityWeather city) {
    context.read<Weather>().removeFavorite(city);
  }
}
