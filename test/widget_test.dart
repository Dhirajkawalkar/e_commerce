import 'package:Cartify/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App compiles and runs without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ECommerceApp());

    // Basic smoke test to make sure it loads into the widget tree
    expect(find.byType(ECommerceApp), findsOneWidget);
  });
}
