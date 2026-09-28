import 'package:flutter_test/flutter_test.dart';
import 'package:lab7/main.dart';

void main() {
  testWidgets('Destini app displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DestiniApp());

    expect(find.text('DESTINI'), findsOneWidget);

    expect(
      find.text(
        'You wake up in a dark forest. You can hear strange sounds nearby.',
      ),
      findsOneWidget,
    );

    expect(find.text('Follow the sound.'), findsOneWidget);

    expect(
      find.text('Walk in the opposite direction.'),
      findsOneWidget,
    );
  });

  testWidgets('Destini changes story after choice', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DestiniApp());

    expect(
      find.text(
        'You wake up in a dark forest. You can hear strange sounds nearby.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Follow the sound.'));
    await tester.pump();

    expect(
      find.text(
        'You discover a small cabin with a light shining through the window.',
      ),
      findsOneWidget,
    );
  });
}