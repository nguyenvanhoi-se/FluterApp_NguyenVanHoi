import 'package:flutter_test/flutter_test.dart';
import 'package:lab2/main.dart';

void main() {
  testWidgets('MiCard app test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyCardApp());

    expect(find.text('Nguyễn Văn Hội'), findsOneWidget);
    expect(find.text('FLUTTER DEVELOPER'), findsOneWidget);
    expect(find.text('+84 345855986'), findsOneWidget);
    expect(find.text('hoinv.23it@vku.udn.vn'), findsOneWidget);
  });
}
