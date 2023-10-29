import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'ButtonsGrid.dart';

class IOWidget extends StatefulWidget {
  const IOWidget({super.key});

  @override
  IOWidgetState createState() => IOWidgetState();
}

class IOWidgetState extends State<IOWidget> {
  final List<String> _buttons = [
    'C',
    '(',
    ')',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @visibleForTesting
  String data = '0';
  @visibleForTesting
  bool syntaxErrorState = false;

  @visibleForTesting
  void onButtonPress(String buttonText) {
    if (syntaxErrorState) {
      _deleteAll();
      syntaxErrorState = false;
    }
    switch (buttonText) {
      case 'C':
        _deleteAll();
      case 'DEL':
        _deleteChar();
      case '=':
        _evaluateCurrentExpression();
      default:
        _addChar(buttonText);
    }
  }

  void _addChar(String char) {
    setState(() {
      //delete initial 0
      if (data.isNotEmpty && data[0] == '0') {
        data = '';
      }
      data = data + char;
    });
  }

  void _deleteChar() {
    setState(() {
      if (data.length <= 1) {
        data = '0';
        return;
      }
      data = data.substring(0, data.length - 1);
    });
  }

  void _deleteAll() {
    setState(() {
      data = '0';
    });
  }

  void _evaluateCurrentExpression() {
    if (data.isEmpty) {
      return;
    }
    setState(() {
      try {
        Expression expression = Expression.parse(data);
        const evaluator = ExpressionEvaluator();
        data = evaluator.eval(expression, <String, dynamic>{}).toString();
      } catch (e) {
        // at the moment this catches all Errors and shows the user Syntax Error
        data = 'Syntax Error';
        syntaxErrorState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      // Output text field
      Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  data,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ))),
      const Divider(
        thickness: 2,
        color: Colors.white10,
      ),
      ButtonsGrid(
        crossAxisCount: 4,
        itemCount: _buttons.length,
        buttonTextList: _buttons,
        buttonPaddingSpacing: 1,
        onPressCallBack: onButtonPress,
      )
    ]);
  }
}
