import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/main.dart';

void main() {
  testWidgets('Magic 8 Ball app test', (WidgetTester tester) async {
    await tester.pumpWidget(const Magic8BallApp());

    expect(find.text('Magic 8 Ball'), findsOneWidget);
    expect(find.text('Ask me anything...'), findsOneWidget);
    expect(find.text('ASK'), findsOneWidget);
  });
}