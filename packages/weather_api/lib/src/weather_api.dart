import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/forecast.dart';
import 'models/location.dart';

class WeatherApiException implements Exception {}

/// {@template weather_api}
/// A client providing access to WeatherApi.
/// {@endtemplate}
class WeatherApi {
  /// {@macro weather_api}
  WeatherApi({
    required String key,
    http.Client? client,
  })  : _key = key,
        _client = client ?? http.Client();

  final String _key;
  final http.Client _client;

  static const baseUrl = 'api.weatherapi.com';

  /// Fetches weather for today from the server.
  Future<Forecast> getForecast(double latitude, double longitude) async {
    final url = Uri.https(baseUrl, '/v1/forecast.json', {
      'q': '$latitude,$longitude',
      'key': _key,
    });

    final response = await _client.get(url);

    if (response.statusCode != 200) {
      throw WeatherApiException();
    }

    final data = jsonDecode(response.body);

    return Forecast.fromJson(data as Map<String, dynamic>);
  }

  /// Fetches completion for the given `query`.
  Future<List<Location>> getCompletion(String query) async {
    final url = Uri.https(baseUrl, '/v1/search.json', {
      'q': query,
      'key': _key,
    });

    final response = await _client.get(url);

    if (response.statusCode != 200) {
      throw WeatherApiException();
    }

    final jsonArray =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    return jsonArray.map<Location>(Location.fromJson).toList();
  }
}
