import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_calculator/main.dart';

void main() {
  testWidgets('Calculator basic addition test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Initial display should be 0
    expect(find.byKey(const Key('display_text')), findsOneWidget);
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '0');

    // Tap '7'
    await tester.tap(find.widgetWithText(ElevatedButton, '7'));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '7');

    // Tap '+'
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    // Tap '5'
    await tester.tap(find.widgetWithText(ElevatedButton, '5'));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '5');

    // Tap '='
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '12');
  });

  testWidgets('Calculator subtraction, multiplication, division and clear test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // 9 - 4 = 5
    await tester.tap(find.widgetWithText(ElevatedButton, '9'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '−'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '4'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '5');

    // Multiply by 6 -> 5 * 6 = 30
    await tester.tap(find.widgetWithText(ElevatedButton, '×'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '6'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '30');

    // Divide by 2 -> 30 / 2 = 15
    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '2'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '15');

    // Test Clear 'C'
    await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '0');

    // Test Division by zero: 8 / 0 = Error
    await tester.tap(find.widgetWithText(ElevatedButton, '8'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '0'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, 'Error');
  });

  testWidgets('Calculator keyboard input test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());
    await tester.pumpAndSettle();

    // Type 4 * 5 = 20 using keyboard numpad keys
    await tester.sendKeyEvent(LogicalKeyboardKey.numpad4);
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '4');

    await tester.sendKeyEvent(LogicalKeyboardKey.numpadMultiply);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.numpad5);
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '5');

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '20');

    // Backspace test
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '2');

    // Clear test via keyC
    await tester.sendKeyEvent(LogicalKeyboardKey.keyC);
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('display_text'))).data, '0');
  });
}

