import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/localization/localization.dart';

import '../models/city_search_result.dart';
import '../providers/search_autocomplete.dart';
import 'widgets/persistent_app_bar.dart';
import 'widgets/persistent_search.dart';
import 'widgets/search_result_sliver.dart';

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
      builder: (context, autocomplete, _) => SearchResultSliver(
        state: autocomplete.state,
        onCityPressed: (city) => _onCityPressed(context, city),
      ),
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
