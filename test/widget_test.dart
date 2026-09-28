import 'package:flutter_test/flutter_test.dart';
import 'package:lab8/main.dart';

void main() {
  testWidgets('BMI Calculator displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BMICalculatorApp());

    expect(find.text('BMI CALCULATOR'), findsOneWidget);
    expect(find.text('MALE'), findsOneWidget);
    expect(find.text('FEMALE'), findsOneWidget);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(find.text('WEIGHT'), findsOneWidget);
    expect(find.text('AGE'), findsOneWidget);
    expect(find.text('CALCULATE'), findsOneWidget);
  });

  testWidgets('BMI Calculator opens result page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BMICalculatorApp());

    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    expect(find.text('Your Result'), findsOneWidget);
    expect(find.text('RE-CALCULATE'), findsOneWidget);
  });
}