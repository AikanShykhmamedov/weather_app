import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/src/presentation/widgets/local_area_page.dart';
import 'package:weather_app/home/src/presentation/widgets/weather_animation.dart';
import 'package:weather_app/localization/localization.dart';

import '../../app_mock.dart';
import '../cities.dart';

void main() {
  tz.initializeTimeZones();

  testWidgets('Location service is disabled', (tester) async {
    final widget = AppMock(
      child: LocalAreaPage(
        isServiceEnabled: false,
        isPermissionGranted: true,
        openLocationSettings: () async {},
        openAppSettings: () async {},
        city: london,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final title = find.text(S.current.location_service_unavailable_title);
    final turnOnButton = find.byType(TextButton);

    expect(title, findsOneWidget);
    expect(turnOnButton, findsOneWidget);
  });

  testWidgets('Location permission is not granted', (tester) async {
    final widget = AppMock(
      child: LocalAreaPage(
        isServiceEnabled: true,
        isPermissionGranted: false,
        openLocationSettings: () async {},
        openAppSettings: () async {},
        city: london,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final title = find.text(S.current.permission_not_granted_title);
    final turnOnButton = find.byType(TextButton);

    expect(title, findsOneWidget);
    expect(turnOnButton, findsOneWidget);
  });

  testWidgets('Location is available, a city is provided', (tester) async {
    final widget = AppMock(
      child: LocalAreaPage(
        isServiceEnabled: true,
        isPermissionGranted: true,
        openLocationSettings: () async {},
        openAppSettings: () async {},
        city: london,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final weatherAnimation = find.byType(WeatherAnimation);

    expect(weatherAnimation, findsOneWidget);
  });
}
