import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_app/app/app_config.dart';

part 'search_autocomplete.freezed.dart';

@freezed
class SearchAutocompleteState with _$SearchAutocompleteState {
  const factory SearchAutocompleteState.initial() = SearchAutocompleteInitial;

  const factory SearchAutocompleteState.loading() = SearchAutocompleteLoading;

  const factory SearchAutocompleteState.error() = SearchAutocompleteError;

  const factory SearchAutocompleteState.success({
    required List<Location> cities,
  }) = SearchAutocompleteSuccess;
}

/// {@template city_autocomplete}
/// Helps to find cities by autocompletion.
/// {@endtemplate}
class SearchAutocomplete extends ChangeNotifier {
  /// {@macro city_autocomplete}
  SearchAutocomplete({
    WeatherApi? client,
  })  : _client = client ?? WeatherApi(key: AppConfig.weatherApiKey),
        _state = const SearchAutocompleteState.initial();

  final WeatherApi _client;

  SearchAutocompleteState get state => _state;
  SearchAutocompleteState _state;

  Timer? _timer;
  CancelableOperation<void>? _operation;

  static const _delay = Duration(milliseconds: 500);
  static const _networkTimeout = Duration(seconds: 10);

  @override
  void dispose() {
    _timer?.cancel();
    _operation?.cancel();
    super.dispose();
  }

  /// Requests completion from the server.
  ///
  /// Waits some time before requesting the server in case a user have not
  /// finished querying. If a new query was called before fetching the previous
  /// request, the latter will be canceled.
  void onQuery(String query) {
    _timer?.cancel();
    _operation?.cancel();

    if (query.isEmpty) {
      _setState(const SearchAutocompleteState.initial());
    } else {
      _setState(const SearchAutocompleteState.loading());

      _timer = Timer(
        _delay,
        () async {
          final task = _client.getCompletion(query).timeout(_networkTimeout);

          // If the operation is canceled "then" part will not be executed.
          _operation =
              CancelableOperation<List<Location>>.fromFuture(task).then(
            (cities) => _setState(
              SearchAutocompleteState.success(cities: cities),
            ),
            onError: (_, __) => _setState(
              const SearchAutocompleteState.error(),
            ),
          );
        },
      );
    }
  }

  void _setState(SearchAutocompleteState state) {
    if (_state != state) {
      _state = state;
      notifyListeners();
    }
  }
}
