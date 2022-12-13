import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/city_search/src/presentation/widgets/search_result_sliver.dart';
import 'package:weather_app/city_search/src/providers/search_autocomplete.dart';
import 'package:weather_app/localization/generated/l10n.dart';

import '../../app_mock.dart';
import '../../home/cities.dart';

void main() {
  testWidgets('Loading state', (tester) async {
    const state = SearchAutocompleteState.loading();

    final widget = AppMock(
      child: CustomScrollView(
        slivers: [
          SearchResultSliver(
            state: state,
            onCityPressed: (_) {},
          ),
        ],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final progressIndicator = find.byType(CircularProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  });

  testWidgets('Error state', (tester) async {
    const state = SearchAutocompleteState.error();

    final widget = AppMock(
      child: CustomScrollView(
        slivers: [
          SearchResultSliver(
            state: state,
            onCityPressed: (_) {},
          ),
        ],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final text = find.text(S.current.city_search_could_not_find);
    expect(text, findsOneWidget);
  });

  testWidgets('Success state. Empty result.', (tester) async {
    const state = SearchAutocompleteState.success(cities: []);

    final widget = AppMock(
      child: CustomScrollView(
        slivers: [
          SearchResultSliver(
            state: state,
            onCityPressed: (_) {},
          ),
        ],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final text = find.text(S.current.city_search_could_not_find);
    expect(text, findsOneWidget);
  });

  testWidgets('Success state. Non-empty result.', (tester) async {
    const state = SearchAutocompleteState.success(cities: [londonLocation]);

    final widget = AppMock(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SearchResultSliver(
              state: state,
              onCityPressed: (_) {},
            ),
          ],
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    final list = find.byType(SliverList);
    expect(list, findsOneWidget);
  });
}
