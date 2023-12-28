// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      // theme: ThemeData(primarySwatch:),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);

        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('−', '-');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;

        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget builtButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      decoration: BoxDecoration(
        color: buttonColor,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
              color: Colors.white, width: 1.0, style: BorderStyle.solid),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Simple Calculator',
          ),
        ),
        body: Column(children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        builtButton("C", 1, Colors.redAccent),
                        builtButton("⌫", 1, Colors.blue),
                        builtButton("÷", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        builtButton("7", 1, Colors.black54),
                        builtButton("8", 1, Colors.black54),
                        builtButton("9", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        builtButton("4", 1, Colors.black54),
                        builtButton("5", 1, Colors.black54),
                        builtButton("6", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        builtButton("1", 1, Colors.black54),
                        builtButton("2", 1, Colors.black54),
                        builtButton("3", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        builtButton(".", 1, Colors.black54),
                        builtButton("0", 1, Colors.black54),
                        builtButton("00", 1, Colors.black54),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        builtButton("×", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        builtButton("−", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        builtButton("+", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        builtButton("=", 2, Colors.redAccent),
                      ])
                    ],
                  ),
                )
              ]),
        ]));
  }
}
