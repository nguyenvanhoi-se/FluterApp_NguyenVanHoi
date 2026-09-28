import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6/main.dart';

void main() {
  testWidgets('Quizzler app displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.text('Quizzler'), findsOneWidget);

    expect(find.text('TRUE'), findsOneWidget);

    expect(find.text('FALSE'), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(2));

    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Quizzler moves to next question', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.text('Question 1/7'), findsOneWidget);

    await tester.tap(find.text('TRUE'));
    await tester.pump();

    expect(find.text('Question 2/7'), findsOneWidget);
  });
}