import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/home/src/models/weather_measure.dart';
import 'package:weather_app/home/src/presentation/drawer/widgets/dismissible_city_item.dart';
import 'package:weather_app/home/src/presentation/drawer/widgets/favorites_sliver.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../../app_mock.dart';
import '../cities.dart';

void main() {
  tz.initializeTimeZones();

  testWidgets('Empty list favorite cities', (tester) async {
    final widget = AppMock(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            FavoritesSliver(
              favoriteCities: const [],
              temperatureMeasure: TemperatureMeasure.celsius,
              onCityPressed: (_) {},
              onCityRemoved: (_) {},
            ),
          ],
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final text = find.text(S.current.drawer_add_cities);
    expect(text, findsOneWidget);
  });

  testWidgets('Non-empty list of favorite cities', (tester) async {
    final widget = AppMock(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            FavoritesSliver(
              favoriteCities: [london],
              temperatureMeasure: TemperatureMeasure.celsius,
              onCityPressed: (_) {},
              onCityRemoved: (_) {},
            ),
          ],
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final item = find.widgetWithText(DismissibleCityItem, london.name);
    expect(item, findsOneWidget);
  });
}