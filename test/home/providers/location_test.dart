import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:location_api/location_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/home/src/providers/location.dart';

class MockLocationApi extends Mock implements LocationApi {}

void main() {
  final locationApi = MockLocationApi();

  late Location location;

  setUp(() {
    location = Location(locationApi: locationApi);
  });

  test('initialize', () async {
    when(() => locationApi.isLocationServiceEnabled())
        .thenAnswer((_) async => true);
    when(() => locationApi.checkPermission())
        .thenAnswer((_) async => LocationPermission.deniedForever);
    when(() => locationApi.getServiceStatusStream())
        .thenAnswer((_) => const Stream<bool>.empty());

    await location.initialize();

    expect(location.isLocationAvailable, isFalse);
    expect(location.isServiceEnabled, isTrue);
    expect(location.isPermissionGranted, isFalse);

    verify(() => locationApi.isLocationServiceEnabled()).called(1);
    verify(() => locationApi.checkPermission()).called(1);
    verify(() => locationApi.getServiceStatusStream()).called(1);
  });

  group('updatePermission', () {
    late Location location;

    setUpAll(() async {
      location = Location(locationApi: locationApi);

      when(() => locationApi.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(() => locationApi.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(() => locationApi.getServiceStatusStream())
          .thenAnswer((_) => const Stream<bool>.empty());

      await location.initialize();

      reset(locationApi);
    });

    test('Denied -> Always', () async {
      expect(location.isPermissionGranted, isFalse);

      when(() => locationApi.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);

      await location.updatePermission();

      expect(location.isPermissionGranted, isTrue);

      verify(() => locationApi.checkPermission()).called(1);
    });

    test('Always -> Denied', () async {
      when(() => locationApi.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(() => locationApi.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      await location.updatePermission();

      expect(location.isPermissionGranted, isFalse);

      verify(() => locationApi.checkPermission()).called(1);
      verify(() => locationApi.requestPermission()).called(1);
    });
  });

  test('requestPermission', () async {
    when(() => locationApi.isLocationServiceEnabled())
        .thenAnswer((_) async => true);
    when(() => locationApi.checkPermission())
        .thenAnswer((_) async => LocationPermission.denied);
    when(() => locationApi.getServiceStatusStream())
        .thenAnswer((_) => const Stream<bool>.empty());

    await location.initialize();

    when(() => locationApi.requestPermission())
        .thenAnswer((_) async => LocationPermission.always);

    await location.requestPermission();

    expect(location.isPermissionGranted, isTrue);

    verify(() => locationApi.requestPermission()).called(1);
  });

  test('serviceStatusStream', () async {
    final streamController = StreamController<bool>();

    when(() => locationApi.isLocationServiceEnabled())
        .thenAnswer((_) async => false);
    when(() => locationApi.checkPermission())
        .thenAnswer((_) async => LocationPermission.denied);
    when(() => locationApi.getServiceStatusStream())
        .thenAnswer((_) => streamController.stream);

    await location.initialize();

    expect(location.isServiceEnabled, isFalse);

    streamController.add(true);

    await Future.delayed(Duration.zero);

    expect(location.isServiceEnabled, isTrue);
  });
}
