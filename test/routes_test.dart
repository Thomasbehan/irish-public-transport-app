import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irish_public_transport_app/pages/Routes.dart';

void main() {
  testWidgets('Routes test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'IPT ALPHA',
      home: new Routes()
    ));

    // Verify that page loads
    expect(find.text('Routes'), findsWidgets);
    //TODO: test with fake data
  });
}
