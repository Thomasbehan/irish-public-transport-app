import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irish_public_transport_app/pages/RouteDetails.dart';

void main() {
  testWidgets('Routes Details test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        title: 'IPT ALPHA',
        home: new RouteDetails(operator: "BAC", route: "1")
    ));

    // Verify that page loads
    expect(find.text('Routes'), findsWidgets);
    //TODO: test with fake data
  });
}
