import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/main.dart';

void main() {
  testWidgets('Xylophone app displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const XylophoneApp());

    expect(find.text('Xylophone'), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(7));

    expect(find.byType(Expanded), findsNWidgets(7));
  });
}