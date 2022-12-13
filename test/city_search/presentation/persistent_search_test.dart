import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/city_search/src/presentation/widgets/persistent_search.dart';

import '../../app_mock.dart';

void main() {
  testWidgets('Check clear button works properly', (tester) async {
    final widget = AppMock(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            PersistentSearch(
              onTextChanged: (_) {},
            ),
          ],
        ),
      ),
    );

    final textField = find.byType(TextField);
    final clearButton = find.widgetWithIcon(IconButton, Icons.cancel_rounded);

    await tester.pumpWidget(widget);
    await tester.pump();

    expect(clearButton, findsNothing);

    await tester.enterText(textField, 'london');
    await tester.pump();

    expect(clearButton, findsOneWidget);

    await tester.tap(clearButton);
    await tester.pump();

    expect(find.text('london'), findsNothing);
    expect(clearButton, findsNothing);
  });
}
