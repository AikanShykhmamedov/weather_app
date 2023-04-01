import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:location_api/location_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/home/src/presentation/drawer/widgets/dismissible_city_item.dart';
import 'package:weather_app/localization/localization.dart';
import 'package:weather_app/main.dart' as app;

class LocationApiMock extends Mock implements LocationApi {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final locationApi = LocationApiMock();

  when(() => locationApi.isLocationServiceEnabled())
      .thenAnswer((_) async => true);
  when(() => locationApi.checkPermission())
      .thenAnswer((_) async => LocationPermission.denied);
  when(() => locationApi.requestPermission())
      .thenAnswer((_) async => LocationPermission.denied);
  when(() => locationApi.getServiceStatusStream())
      .thenAnswer((_) => const Stream.empty());

  testWidgets(
      'Location permission is denied. Check if there is a page to request it.',
      (tester) async {
    app.main(locationApi: locationApi);

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump();

    // Swipe left to LocalAreaPage
    final pageView = find.byType(PageView);
    await tester.fling(pageView, const Offset(500, 0), 500);
    await tester.pump(const Duration(seconds: 1));

    final notGrantedTitle = find.text(S.current.permission_not_granted_title);
    final turnOnButton =
        find.widgetWithText(TextButton, S.current.turn_on_location);

    expect(notGrantedTitle, findsOneWidget);
    expect(turnOnButton, findsOneWidget);
  });

  testWidgets('Add, check and delete a favorite city', (tester) async {
    app.main(locationApi: locationApi);

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump();

    // Open the drawer
    final menuButton = find.widgetWithIcon(IconButton, Icons.menu_rounded);
    await tester.tap(menuButton);
    await tester.pump(const Duration(seconds: 1));

    // Open CitySearchScreen
    final addFavoriteButton = find.widgetWithIcon(IconButton, Icons.add_circle);
    await tester.tap(addFavoriteButton);
    await tester.pump(const Duration(seconds: 1));

    // Enter text
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'london');
    await tester.pump();
    await tester.pumpAndSettle();

    // Choose a city
    final londonItem = find.widgetWithText(ListTile, 'London');
    await tester.tap(londonItem);
    await tester.pump(const Duration(seconds: 1));

    // Wait for App to fetch CityWeather and add it to the list
    await Future<void>.delayed(const Duration(seconds: 3));
    await tester.pump();

    final londonFavoriteCity =
        find.widgetWithText(DismissibleCityItem, 'London');

    expect(londonFavoriteCity, findsOneWidget);

    // Press on the city (closes the drawer and opens the corresponding page)
    await tester.tap(londonFavoriteCity);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('London'), findsOneWidget);

    // Open the drawer
    await tester.tap(menuButton);
    await tester.pump(const Duration(seconds: 1));

    // Swipe to remove the city
    await tester.fling(londonFavoriteCity, const Offset(-300, 0), 300);
    await tester.pump(const Duration(seconds: 1));

    expect(londonFavoriteCity, findsNothing);
  });
}
