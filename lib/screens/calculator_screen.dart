import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "";
  bool lastPressedEquals = false; // Tracks if last press was "="

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = "";
        result = "";
        lastPressedEquals = false;
      } else if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        if (input.isNotEmpty) {
          result = calculateResult(input);
          lastPressedEquals = true;
        }
      } else {
        // If last pressed "=" and new input is an operator, continue from result
        if (lastPressedEquals) {
          if (isOperator(value)) {
            input = result + value;
          } else {
            input = value; // start new calculation
            result = "";
          }
          lastPressedEquals = false;
        } else {
          // Prevent multiple operators in a row
          if (input.isNotEmpty &&
              isOperator(input[input.length - 1]) &&
              isOperator(value)) {
            input = input.substring(0, input.length - 1) + value;
          } else {
            input += value;
          }
        }
      }
    });
  }

  bool isOperator(String s) {
    return s == '+' || s == '-' || s == '×' || s == 'x' || s == '÷' || s == '*';
  }

  String calculateResult(String exp) {
    try {
      // Replace symbols
      exp = exp.replaceAll('×', '*').replaceAll('x', '*').replaceAll('÷', '/');

      // Replace % with /100
      exp = exp.replaceAll('%', '/100');

      Parser p = Parser();
      Expression parsedExp = p.parse(exp);
      ContextModel cm = ContextModel();

      double eval = parsedExp.evaluate(EvaluationType.REAL, cm);

      // Remove ".0" for integers
      if (eval == eval.toInt()) {
        return eval.toInt().toString();
      }

      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Input Display
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              input,
              style: const TextStyle(color: Colors.white, fontSize: 36),
            ),
          ),

          // Result Display
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              result,
              style: const TextStyle(color: Colors.green, fontSize: 45),
            ),
          ),

          const SizedBox(height: 20),

          // Buttons Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(10),
              children: [
                CalculatorButton(
                  text: "C",
                  color: const Color.fromARGB(255, 231, 43, 29),
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "⌫",
                  color: const Color.fromARGB(255, 197, 52, 52),
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "%",
                  color: Colors.amber,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "÷",
                  color: Colors.amber,
                  onTap: buttonPressed,
                ),

                CalculatorButton(
                  text: "7",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "8",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "9",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "×",
                  color: Colors.amber,
                  onTap: buttonPressed,
                ),

                CalculatorButton(
                  text: "4",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "5",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "6",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "-",
                  color: Colors.amber,
                  onTap: buttonPressed,
                ),

                CalculatorButton(
                  text: "1",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "2",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "3",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "+",
                  color: Colors.amber,
                  onTap: buttonPressed,
                ),

                CalculatorButton(
                  text: "0",
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: ".",
                  color: const Color.fromARGB(255, 152, 128, 128)!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "=",
                  color: const Color.fromARGB(255, 30, 197, 35),
                  onTap: buttonPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
