import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irish_public_transport_app/pages/Home.dart';

void main() {
  testWidgets('Homepage test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'IPT ALPHA',
      home: new HomePage(),
    ));

    // Verify that all cards are swipeable
    expect(find.text('FAVOURITES').first, findsOneWidget);
    await tester.drag(find.text("FAVOURITES").first, Offset(-600.0, 200.0));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('ROUTES').first, findsOneWidget);
    await tester.drag(find.text("View All Available Routes"), Offset(-600.0, 200.0));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('STOPS').first, findsOneWidget);
    await tester.drag(find.text("STOPS").first, Offset(-600.0, 200.0));
    await tester.pump(const Duration(seconds: 1));
  });
}
