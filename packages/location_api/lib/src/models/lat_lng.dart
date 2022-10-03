/// {@template lat_lng}
/// Represents a coordinate.
/// {@endtemplate}
class LatLng {
  /// {@macro lat_lng}
  const LatLng(this.latitude, this.longitude)
      : assert(-90 <= latitude && latitude <= 90),
        assert(-180 <= longitude && longitude <= 180);

  final double latitude;
  final double longitude;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is LatLng &&
          other.latitude == latitude &&
          other.longitude == longitude);

  @override
  int get hashCode => Object.hash(latitude, longitude);

  @override
  String toString() {
    return 'LatLng($latitude, $longitude)';
  }
}
