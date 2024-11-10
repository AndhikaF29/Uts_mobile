import 'package:flutter/material.dart';
import '../calculators/basic_calculator.dart';

class BasicCalculatorScreen extends StatefulWidget {
  const BasicCalculatorScreen({super.key});

  @override
  State<BasicCalculatorScreen> createState() => _BasicCalculatorScreenState();
}

class _BasicCalculatorScreenState extends State<BasicCalculatorScreen> {
  String _display = '0';
  String _currentNumber = '';
  double? _firstNumber;
  String? _operation;
  bool _newNumber = true;

  void _onNumberPressed(String number) {
    setState(() {
      if (_newNumber) {
        _display = number;
        _newNumber = false;
      } else {
        _display = _display + number;
      }
      _currentNumber = _display;
    });
  }

  void _onOperationPressed(String operation) {
    if (_firstNumber == null) {
      _firstNumber = double.parse(_currentNumber);
    } else if (_operation != null) {
      _calculateResult();
    }

    setState(() {
      _operation = operation;
      _newNumber = true;
    });
  }

  void _calculateResult() {
    if (_firstNumber == null || _operation == null || _currentNumber.isEmpty) {
      return;
    }

    double secondNumber = double.parse(_currentNumber);
    double result;

    try {
      switch (_operation) {
        case '+':
          result = BasicCalculator.add(_firstNumber!, secondNumber);
          break;
        case '-':
          result = BasicCalculator.subtract(_firstNumber!, secondNumber);
          break;
        case '×':
          result = BasicCalculator.multiply(_firstNumber!, secondNumber);
          break;
        case '÷':
          result = BasicCalculator.divide(_firstNumber!, secondNumber);
          break;
        default:
          return;
      }

      setState(() {
        _display = result.toString();
        _firstNumber = result;
        _currentNumber = result.toString();
        _operation = null;
      });
    } catch (e) {
      setState(() {
        _display = 'Error';
        _clear();
      });
    }
  }

  void _clear() {
    setState(() {
      _display = '0';
      _currentNumber = '';
      _firstNumber = null;
      _operation = null;
      _newNumber = true;
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
        _currentNumber = _display;
      } else {
        _display = '0';
        _currentNumber = '';
        _newNumber = true;
      }
    });
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (color ?? Colors.grey[300]!).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Colors.white,
              foregroundColor:
                  textColor ?? (color != null ? Colors.white : Colors.black87),
              padding: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: () {
              if (text == 'C') {
                _clear();
              } else if (text == '=') {
                _calculateResult();
              } else if (text == '⌫') {
                _onBackspacePressed();
              } else if (['+', '-', '×', '÷'].contains(text)) {
                _onOperationPressed(text);
              } else {
                _onNumberPressed(text);
              }
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'Kalkulator Dasar',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 40), // untuk menyeimbangkan layout
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _display,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildButton('C', color: Colors.red.shade400),
                            _buildButton('(', color: Colors.grey.shade700),
                            _buildButton(')', color: Colors.grey.shade700),
                            _buildButton('÷', color: Colors.orange.shade400),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                            _buildButton('×', color: Colors.orange.shade400),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                            _buildButton('-', color: Colors.orange.shade400),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                            _buildButton('+', color: Colors.orange.shade400),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _buildButton('0'),
                            _buildButton('.'),
                            _buildButton('⌫', color: Colors.grey.shade700),
                            _buildButton('=', color: Colors.green.shade400),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
