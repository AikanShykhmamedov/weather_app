/// {@template city_search_result}
/// A result that represents the coordinate of a city.
/// {@endtemplate}
class CitySearchResult {
  /// {@macro city_search_result}
  const CitySearchResult(
    this.latitude,
    this.longitude,
  );

  final double latitude;
  final double longitude;
}
