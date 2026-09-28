import 'package:flutter_test/flutter_test.dart';
import 'package:lab3/main.dart';

void main() {
  testWidgets('Dice app test', (WidgetTester tester) async {
    await tester.pumpWidget(const DiceApp());

    expect(find.text('Dice'), findsOneWidget);
    expect(find.text('ROLL DICE'), findsOneWidget);
  });
}