import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/localization/localization.dart';

import '../models/city_search_result.dart';
import '../providers/search_autocomplete.dart';
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
    final appBar = SliverAppBar.large(
      title: Text(S.of(context).city_search_title),
    );

    final search = PersistentSearch(
      onTextChanged: context.read<SearchAutocomplete>().onQuery,
    );

    final content = Consumer<SearchAutocomplete>(
      builder: (context, autocomplete, _) => SearchResultSliver(
        state: autocomplete.state,
        onCityPressed: (city) => _onCityPressed(context, city),
      ),
    );

    return Scaffold(
      body: CustomScrollView(
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

  void _onCityPressed(BuildContext context, Location location) {
    final result = CitySearchResult(location.lat, location.lon);

    Navigator.pop<CitySearchResult>(context, result);
  }
}
