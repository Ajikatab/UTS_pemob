import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentNumber = "";
  List<String> _expression = [];
  bool _newNumber = true;

  double _calculateExpression(List<String> expr) {
    List<String> tempExpr = [];
    for (int i = 0; i < expr.length; i++) {
      if (i + 1 < expr.length && (expr[i + 1] == "×" || expr[i + 1] == "÷")) {
        double num1 = double.parse(tempExpr.removeLast());
        double num2 = double.parse(expr[i + 2]);
        double result;
        if (expr[i + 1] == "×") {
          result = num1 * num2;
        } else {
          result = num2 != 0 ? num1 / num2 : double.nan;
        }
        tempExpr.add(result.toString());
        i += 2;
      } else {
        tempExpr.add(expr[i]);
      }
    }

    double result = double.parse(tempExpr[0]);
    for (int i = 1; i < tempExpr.length; i += 2) {
      if (i + 1 >= tempExpr.length) break;
      double num = double.parse(tempExpr[i + 1]);
      if (tempExpr[i] == "+") {
        result += num;
      } else if (tempExpr[i] == "-") {
        result -= num;
      }
    }
    return result;
  }

  String _formatNumber(String number) {
    double? value = double.tryParse(number);
    if (value == null) return number;
    return value == value.toInt() ? value.toInt().toString() : value.toStringAsFixed(2);
  }

  String _formatExpression() {
    List<String> formattedExpr = _expression.map((e) {
      if (double.tryParse(e) != null) {
        return _formatNumber(e);
      }
      return e;
    }).toList();
    
    return formattedExpr.join(' ');
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Menghapus seluruh ekspresi dan angka
        _output = "0";
        _currentNumber = "";
        _expression = [];
        _newNumber = true;
      } else if (buttonText == "⌫") {
        // Penghapusan satu karakter
        if (_currentNumber.isNotEmpty) {
          // Jika ada angka yang sedang diketik, hapus satu karakter
          _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
          _output = _currentNumber.isEmpty ? "0" : _currentNumber;
        } else if (_expression.isNotEmpty) {
          // Jika tidak ada angka yang diketik, hapus operator atau angka terakhir dari ekspresi
          String last = _expression.removeLast();
          if (_expression.isNotEmpty) {
            _output = _formatExpression();
            _currentNumber = _expression.last;
          } else {
            _output = "0";
            _currentNumber = "";
          }
        }
      } else if (buttonText == "+" || buttonText == "-" ||
          buttonText == "×" || buttonText == "÷") {
        if (_currentNumber.isNotEmpty) {
          _expression.add(_currentNumber);
          _expression.add(buttonText);
          _newNumber = true;
          _currentNumber = "";
        } else if (_expression.isNotEmpty && 
                   (_expression.last == "+" || _expression.last == "-" ||
                    _expression.last == "×" || _expression.last == "÷")) {
          _expression.last = buttonText;
        }
        _output = _formatExpression();
      } else if (buttonText == "=") {
        if (_currentNumber.isNotEmpty) {
          _expression.add(_currentNumber);
        }
        if (_expression.isNotEmpty) {
          double result = _calculateExpression(_expression);
          _output = _formatNumber(result.toString());
          _currentNumber = _output;  // Memastikan output disalin ke _currentNumber
          _expression = [];
          _newNumber = true;
        }
      } else if (buttonText == "±") {
        if (_currentNumber.isNotEmpty) {
          if (_currentNumber.startsWith("-")) {
            _currentNumber = _currentNumber.substring(1);
          } else {
            _currentNumber = "-$_currentNumber";
          }
          _output = _expression.isEmpty ? _currentNumber : "${_formatExpression()} $_currentNumber";
        }
      } else if (buttonText == ".") {
        if (_newNumber) {
          _currentNumber = "0";
          _newNumber = false;
        }
        if (!_currentNumber.contains(".")) {
          _currentNumber = (_currentNumber.isEmpty ? "0" : _currentNumber) + buttonText;
          _output = _expression.isEmpty ? _currentNumber : "${_formatExpression()} $_currentNumber";
        }
      } else if (buttonText == "√") {
        if (_currentNumber.isNotEmpty) {
          double number = double.parse(_currentNumber);
          double result = sqrt(number);
          _currentNumber = _formatNumber(result.toString());
          _output = _expression.isEmpty ? _currentNumber : "${_formatExpression()} $_currentNumber";
        }
      } else if (buttonText == "x²") {
        if (_currentNumber.isNotEmpty) {
          double number = double.parse(_currentNumber);
          double result = number * number;
          _currentNumber = _formatNumber(result.toString());
          _output = _expression.isEmpty ? _currentNumber : "${_formatExpression()} $_currentNumber";
        }
      } else {
        if (_newNumber) {
          _currentNumber = buttonText;
          _newNumber = false;
        } else {
          _currentNumber += buttonText;
        }
        _output = _expression.isEmpty ? _currentNumber : "${_formatExpression()} $_currentNumber";
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF333333),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        title: const Text('Standard'),
        centerTitle: true, // Menengahkan judul
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                _output,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("⌫"), // Menambahkan tombol "⌫" untuk penghapusan satu karakter
                ],
              ),
              Row(
                children: [
                  _buildButton("x²"),
                  _buildButton("√"),
                  _buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("×"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+"),
                ],
              ),
              Row(
                children: [
                  _buildButton("±"),
                  _buildButton("0"),
                  _buildButton("."),
                  _buildButton("=", color: Colors.redAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
