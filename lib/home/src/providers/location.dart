import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:location_api/location_api.dart';

/// {@template location}
/// A class responsible for location.
/// {@endtemplate}
class Location extends ChangeNotifier {
  /// {@macro location}
  Location({
    LocationApi? locationApi,
  }) : _locationApi = locationApi ?? const LocationApi();

  final LocationApi _locationApi;

  /// Checks whether both service is enabled and permission is granted.
  bool get isLocationAvailable => isServiceEnabled && isPermissionGranted;

  /// Checks whether location service is enabled.
  bool get isServiceEnabled => _isServiceEnabled;
  late bool _isServiceEnabled;

  /// Checks whether permission is granted.
  ///
  /// That is a user did not deny and deny forever the permission.
  bool get isPermissionGranted =>
      _permission != LocationPermission.denied &&
      _permission != LocationPermission.deniedForever;
  late LocationPermission _permission;

  late final StreamSubscription<bool> _serviceStatusSubscription;

  @override
  void dispose() {
    _serviceStatusSubscription.cancel();
    super.dispose();
  }

  /// Initializes service availability and permission.
  Future<void> initialize() async {
    _isServiceEnabled = await _locationApi.isLocationServiceEnabled();
    _permission = await _locationApi.checkPermission();
    _serviceStatusSubscription =
        _locationApi.getServiceStatusStream().listen(_serviceStatusListener);

    notifyListeners();
  }

  /// Updates current permission and requests if possible.
  Future<void> updatePermission() async {
    var permission = await _locationApi.checkPermission();

    // Android does not return `LocationPermission.deniedForever`. In order to
    // workaround this we call the `requestPermission` method that in its turn
    // may return `LocationPermission.deniedForever`.
    if (permission == LocationPermission.denied) {
      permission = await _locationApi.requestPermission();
    }

    if (_permission != permission) {
      _permission = permission;
      notifyListeners();
    }
  }

  /// Shows a permission dialog.
  Future<void> requestPermission() async {
    final permission = await _locationApi.requestPermission();

    if (_permission != permission) {
      _permission = permission;
      notifyListeners();
    }
  }

  /// Opens the App settings.
  Future<void> openAppSettings() async {
    await _locationApi.openAppSettings();
  }

  /// Opens location settings.
  Future<void> openLocationSettings() async {
    await _locationApi.openLocationSettings();
  }

  void _serviceStatusListener(bool enabled) {
    _isServiceEnabled = enabled;
    notifyListeners();
  }
}
