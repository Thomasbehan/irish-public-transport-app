import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irish_public_transport_app/pages/Stops.dart';

void main() {
  testWidgets('Stops test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'IPT ALPHA',
      home: Stops()
    ));

    // Verify that page loads
    expect(find.text('Stops & Terminals'), findsWidgets);

    //TODO: test with fake data
  });
}
