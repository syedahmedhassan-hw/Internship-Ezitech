import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final FocusNode _focusNode = FocusNode();
  String display = '0';
  double? firstOperand;
  String? operator;
  bool shouldResetDisplay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void pressButton(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        firstOperand = null;
        operator = null;
        shouldResetDisplay = false;
      } else if (value == '+' || value == '−' || value == '×' || value == '÷') {
        if (display == 'Error') {
          return;
        }
        if (firstOperand != null && operator != null && !shouldResetDisplay) {
          final double secondOperand = double.tryParse(display) ?? 0;
          final double? result = _calculate(firstOperand!, secondOperand, operator!);
          if (result == null) {
            display = 'Error';
            firstOperand = null;
            operator = null;
            shouldResetDisplay = true;
            return;
          }
          display = _formatNumber(result);
          firstOperand = result;
        } else {
          firstOperand = double.tryParse(display) ?? 0;
        }
        operator = value;
        shouldResetDisplay = true;
      } else if (value == '=') {
        if (display == 'Error') {
          return;
        }
        if (firstOperand != null && operator != null) {
          final double secondOperand = double.tryParse(display) ?? 0;
          final double? result = _calculate(firstOperand!, secondOperand, operator!);
          if (result == null) {
            display = 'Error';
          } else {
            display = _formatNumber(result);
          }
          firstOperand = null;
          operator = null;
          shouldResetDisplay = true;
        }
      } else {
        // Number pressed
        if (display == '0' || display == 'Error' || shouldResetDisplay) {
          display = value;
          shouldResetDisplay = false;
        } else {
          display += value;
        }
      }
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final key = event.logicalKey;
    final char = event.character;

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.numpadEnter) {
      pressButton('=');
      return;
    }
    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.keyC) {
      pressButton('C');
      return;
    }
    if (key == LogicalKeyboardKey.backspace) {
      setState(() {
        if (display.length > 1 && display != 'Error') {
          display = display.substring(0, display.length - 1);
        } else {
          display = '0';
        }
      });
      return;
    }

    if (char != null && char.isNotEmpty) {
      if ('0123456789'.contains(char)) {
        pressButton(char);
      } else if (char == '+') {
        pressButton('+');
      } else if (char == '-' || char == '−') {
        pressButton('−');
      } else if (char == '*' || char == '×') {
        pressButton('×');
      } else if (char == '/' || char == '÷') {
        pressButton('÷');
      } else if (char == '=') {
        pressButton('=');
      } else if (char == 'c' || char == 'C') {
        pressButton('C');
      }
      return;
    }

    // Fallback for numpad keys if char is null
    if (key == LogicalKeyboardKey.numpad0 || key == LogicalKeyboardKey.digit0) {
      pressButton('0');
    } else if (key == LogicalKeyboardKey.numpad1 || key == LogicalKeyboardKey.digit1) {
      pressButton('1');
    } else if (key == LogicalKeyboardKey.numpad2 || key == LogicalKeyboardKey.digit2) {
      pressButton('2');
    } else if (key == LogicalKeyboardKey.numpad3 || key == LogicalKeyboardKey.digit3) {
      pressButton('3');
    } else if (key == LogicalKeyboardKey.numpad4 || key == LogicalKeyboardKey.digit4) {
      pressButton('4');
    } else if (key == LogicalKeyboardKey.numpad5 || key == LogicalKeyboardKey.digit5) {
      pressButton('5');
    } else if (key == LogicalKeyboardKey.numpad6 || key == LogicalKeyboardKey.digit6) {
      pressButton('6');
    } else if (key == LogicalKeyboardKey.numpad7 || key == LogicalKeyboardKey.digit7) {
      pressButton('7');
    } else if (key == LogicalKeyboardKey.numpad8 || key == LogicalKeyboardKey.digit8) {
      pressButton('8');
    } else if (key == LogicalKeyboardKey.numpad9 || key == LogicalKeyboardKey.digit9) {
      pressButton('9');
    } else if (key == LogicalKeyboardKey.numpadAdd || key == LogicalKeyboardKey.add) {
      pressButton('+');
    } else if (key == LogicalKeyboardKey.numpadSubtract || key == LogicalKeyboardKey.minus) {
      pressButton('−');
    } else if (key == LogicalKeyboardKey.numpadMultiply) {
      pressButton('×');
    } else if (key == LogicalKeyboardKey.numpadDivide || key == LogicalKeyboardKey.slash) {
      pressButton('÷');
    } else if (key == LogicalKeyboardKey.equal) {
      pressButton('=');
    }
  }

  double? _calculate(double num1, double num2, String op) {
    switch (op) {
      case '+':
        return num1 + num2;
      case '−':
      case '-':
        return num1 - num2;
      case '×':
      case '*':
        return num1 * num2;
      case '÷':
      case '/':
        if (num2 == 0) {
          return null; // Division by zero
        }
        return num1 / num2;
      default:
        return num2;
    }
  }

  String _formatNumber(double number) {
    if (number.isNaN || number.isInfinite) {
      return 'Error';
    }
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }
    // Clean up trailing decimal zeros
    String str = number.toStringAsFixed(6);
    str = str.replaceAll(RegExp(r'0+$'), '');
    str = str.replaceAll(RegExp(r'\.$'), '');
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Calculator'),
          centerTitle: true,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      display,
                      key: const Key('display_text'),
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  children: [
                    calculatorButton('7'),
                    calculatorButton('8'),
                    calculatorButton('9'),
                    calculatorButton('÷'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('4'),
                    calculatorButton('5'),
                    calculatorButton('6'),
                    calculatorButton('×'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('1'),
                    calculatorButton('2'),
                    calculatorButton('3'),
                    calculatorButton('−'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('C'),
                    calculatorButton('0'),
                    calculatorButton('='),
                    calculatorButton('+'),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget calculatorButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            pressButton(text);
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}