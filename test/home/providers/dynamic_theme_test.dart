import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/home.dart';

import '../cities.dart';

void main() {
  tz.initializeTimeZones();

  final dynamicTheme = DynamicTheme();

  final londonThemeData = DynamicThemeData.from(london);
  final parisThemeData = DynamicThemeData.from(paris);

  group('set', () {
    test('Non null', () {
      dynamicTheme.set(london);

      expect(dynamicTheme.themeData, londonThemeData);
      expect(dynamicTheme.continuousThemeData, londonThemeData);
    });

    test('Null', () {
      dynamicTheme.set(null);

      expect(dynamicTheme.themeData, londonThemeData);
      expect(dynamicTheme.continuousThemeData, londonThemeData);
    });
  });

  group('lerp', () {
    for (final t in [0.0, 0.25, 0.75, 1.0]) {
      test('London->Paris ($t)', () {
        dynamicTheme.lerp(london, paris, t);

        expect(
          dynamicTheme.themeData,
          t < 0.5 ? londonThemeData : parisThemeData,
        );

        expect(
          dynamicTheme.continuousThemeData,
          DynamicThemeData.lerp(londonThemeData, parisThemeData, t),
        );
      });
    }
  });
}
