import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab9/main.dart';

void main() {
  testWidgets(
    'Clima app displays correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ClimaApp(),
      );

      expect(
        find.text('CLIMA'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.my_location),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.location_city),
        findsOneWidget,
      );
    },
  );
}