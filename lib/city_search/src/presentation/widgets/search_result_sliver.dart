import 'package:flutter/material.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/localization/localization.dart';

import '../../providers/search_autocomplete.dart';

class SearchResultSliver extends StatelessWidget {
  const SearchResultSliver({
    super.key,
    required this.state,
    required this.onCityPressed,
  });

  final SearchAutocompleteState state;
  final void Function(Location) onCityPressed;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return state.when<Widget>(
      initial: () => const SliverFillRemaining(hasScrollBody: false),
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
      ),
      error: () => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              S.of(context).city_search_could_not_find,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!,
            ),
          ),
        ),
      ),
      success: (cities) {
        if (cities.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  S.of(context).city_search_could_not_find,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!,
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: cities.length,
              (context, index) {
                final city = cities[index];

                return ListTile(
                  onTap: () => onCityPressed(city),
                  leading: const Icon(Icons.place_outlined),
                  minVerticalPadding: 12,
                  minLeadingWidth: 24,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(city.name),
                  ),
                  subtitle: Text('${city.country}, ${city.region}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
