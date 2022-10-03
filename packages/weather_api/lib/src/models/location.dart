import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// {@template location}
/// Information about city location.
/// {@endtemplate}
@JsonSerializable()
class Location extends Equatable {
  /// {@macro location}
  const Location(
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
  );

  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  /// TimeZone identifier.
  ///
  /// For autocompletion is null.
  final String? tzId;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  List<Object?> get props => [name, region, country, lat, lon, tzId];

  @override
  bool get stringify => true;
}
