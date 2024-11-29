import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _operation = '';
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;

  void _onNumberPressed(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _operation = operation;
      _firstNumber = double.parse(_display);
      _display = '0';
    });
  }

  void _onEqualsPressed() {
    setState(() {
      _secondNumber = double.parse(_display);
      double result = 0.0;
      switch (_operation) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '*':
          result = _firstNumber * _secondNumber;
          break;
        case '/':
          if (_secondNumber == 0) {
            _display = 'Error';
            return;
          }
          result = _firstNumber / _secondNumber;
          break;
        default:
          _display = 'Error';
          return;
      }
      _display = result.toString();
      _operation = '';
      _firstNumber = 0.0;
      _secondNumber = 0.0;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _operation = '';
      _firstNumber = 0.0;
      _secondNumber = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saddams and Mirza Calculator',
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style:
                  const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('C', onPressed: _onClearPressed),
              _buildButton('0'),
              _buildButton('=', onPressed: _onEqualsPressed),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, {Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () => _onNumberPressed(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      ),
      child: Text(label, style: const TextStyle(fontSize: 24.0)),
    );
  }
}
