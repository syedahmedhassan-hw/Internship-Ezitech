import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appy/main.dart';

void main() {
  testWidgets('OmniSenseApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const OmniSenseApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
