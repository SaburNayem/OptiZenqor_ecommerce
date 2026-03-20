import 'package:flutter_test/flutter_test.dart';
import 'package:optizenqor/app.dart';

void main() {
  testWidgets('renders splash then auth choice screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OptiZenqor());

    expect(find.text('OmniZara'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Shop smarter, every day'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });
}
