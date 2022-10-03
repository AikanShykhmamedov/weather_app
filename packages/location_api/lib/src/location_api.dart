import 'package:geolocator/geolocator.dart';
import 'models/lat_lng.dart';

/// {@template location_api}
/// A client providing access to the location service.
/// {@endtemplate}
class LocationApi {
  /// {@macro location_api}
  const LocationApi();

  /// Returns current position.
  Future<LatLng> getCurrentPosition() =>
      Geolocator.getCurrentPosition().then<LatLng>(
        (position) => LatLng(position.latitude, position.longitude),
      );

  /// Checks whether the location service enabled.
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  /// Returns [Stream] that listens for the location service status changes.
  Stream<bool> getServiceStatusStream() {
    return Geolocator.getServiceStatusStream()
        .map<bool>((status) => status == ServiceStatus.enabled);
  }

  /// Returns current permission status of the location.
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  /// Requests permission to access the location.
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  /// Opens the location settings.
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  /// Opens the App settings.
  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
