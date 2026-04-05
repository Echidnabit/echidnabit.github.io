import 'package:echidnabit_website_flutter/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders landing page content', (tester) async {
    tester.view.physicalSize = const Size(1440, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const EchidnabitWebsiteApp());
    await tester.pumpAndSettle();

    expect(find.text('Echidnabit'), findsOneWidget);
    expect(find.text('Contact me'), findsOneWidget);
    expect(find.text('Tessellate'), findsOneWidget);
    expect(find.text('Pitchi'), findsOneWidget);
  });

  testWidgets('renders privacy policy route content', (tester) async {
    await tester.pumpWidget(
      const EchidnabitWebsiteApp(initialRouteOverride: '/privacy-policy'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Echidnabit Privacy Policy'), findsOneWidget);
    expect(find.text('1. Data collection'), findsOneWidget);
  });

  testWidgets('contact and download calls to action are tappable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const EchidnabitWebsiteApp());
    await tester.pumpAndSettle();

    expect(find.text('echidnabit@gmail.com'), findsOneWidget);
    expect(find.text('Download for iPhone'), findsNWidgets(2));

    await tester.tap(find.text('echidnabit@gmail.com'));
    await tester.pump(const Duration(milliseconds: 250));
  });
}
