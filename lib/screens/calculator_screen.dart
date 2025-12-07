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
  bool lastPressedEquals = false;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = "";
        result = "";
        lastPressedEquals = false;
      } else if (value == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        if (input.isNotEmpty) {
          result = calculateResult(input);
          lastPressedEquals = true;
        }
      } else {
        if (lastPressedEquals) {
          if (isOperator(value)) {
            input = result + value;
          } else {
            input = value;
            result = "";
          }
          lastPressedEquals = false;
        } else {
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
      exp = exp.replaceAll('×', '*').replaceAll('x', '*').replaceAll('÷', '/');
      exp = exp.replaceAll('%', '/100');

      Parser p = Parser();
      Expression parsedExp = p.parse(exp);
      ContextModel cm = ContextModel();

      double eval = parsedExp.evaluate(EvaluationType.REAL, cm);

      if (eval == eval.toInt()) return eval.toInt().toString();
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
        children: [
          const SizedBox(height: 100),

          // Big Rectangle for input + result
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  result,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 239, 242, 239),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 100),

          // Buttons grid (all same style)
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(10),
              childAspectRatio: 1.2,
              children: [
                CalculatorButton(
                  text: "C",
                  color: Colors.red, // custom color
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "⌫",
                  color: Colors.orange, // custom color
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
                  color: Colors.grey[850]!,
                  onTap: buttonPressed,
                ),
                CalculatorButton(
                  text: "=",
                  color: Colors.lightGreen,
                  onTap: buttonPressed,
                ),
                const SizedBox(), // empty to balance grid
              ],
            ),
          ),
        ],
      ),
    );
  }
}
