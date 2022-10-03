import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../models/city_search_result.dart';
import '../providers/search_autocomplete.dart';
import 'widgets/persistent_app_bar.dart';
import 'widgets/persistent_search.dart';

/// {@template city_search_screen}
/// A screen that provides search to find a city with autocompletion.
/// {@endtemplate}
class CitySearchScreen extends StatelessWidget {
  /// {@macro city_search_screen}
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchAutocomplete>(
      create: (_) => SearchAutocomplete(),
      child: const _CitySearchView(),
    );
  }
}

class _CitySearchView extends StatefulWidget {
  const _CitySearchView();

  @override
  State<_CitySearchView> createState() => _CitySearchViewState();
}

class _CitySearchViewState extends State<_CitySearchView> {
  @override
  void initState() {
    super.initState();

    final autocomplete = context.read<SearchAutocomplete>();
    autocomplete.addListener(() => _autocompleteListener(autocomplete));
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final appBar = PersistentAppBar(
      largeTitle: Text(
        S.of(context).city_search_title,
        style: Theme.of(context).textTheme.headlineLarge!,
      ),
      // TODO: No ripple effect
      leading: IconButton(
        onPressed: () => _onBackPressed(context),
        icon: const Icon(Icons.close_rounded),
      ),
    );

    final search = PersistentSearch(
      onTextChanged: context.read<SearchAutocomplete>().onQuery,
      autofocus: true,
    );

    final content = Consumer<SearchAutocomplete>(
      builder: (context, autocomplete, _) {
        return autocomplete.state.when<Widget>(
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
                      onTap: () => _onCityPressed(context, city),
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
      },
    );

    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          appBar,
          search,
          content,
        ],
      ),
    );
  }

  void _autocompleteListener(SearchAutocomplete autocomplete) {
    autocomplete.state.mapOrNull(
      error: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Theme.of(context).colorScheme.onError,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(S.current.error_occurred),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCityPressed(BuildContext context, Location location) {
    final result = CitySearchResult(location.lat, location.lon);

    Navigator.pop<CitySearchResult>(context, result);
  }
}
