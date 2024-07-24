import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class hesapMakinesi extends StatefulWidget {
  const hesapMakinesi({super.key});

  @override
  State<hesapMakinesi> createState() => _hesapMakinesiState();
}

class _hesapMakinesiState extends State<hesapMakinesi> {
  var tfController = TextEditingController();
  String display = '';
  String operator = '';
  double firstNumber = 0;
  double secondNumber = 0;

  void onNumberPress(String number) {
    setState(() {
      display += number;
      tfController.text = display; // Güncellenen değeri TextField'a yansıtır
    });
  }

  void onOperatorPress(String oper) {
    setState(() {
      if (display.isNotEmpty && operator.isEmpty) {
        firstNumber = double.parse(display);
        operator = oper;
        display += oper;
        tfController.text = display; // Operatörü ekler ve TextField'ı günceller
      }
    });
  }

  void onEqualPress() {
    setState(() {
      if (operator.isNotEmpty && display.isNotEmpty) {
        var parts = display.split(operator);
        if (parts.length == 2) {
          firstNumber = double.parse(parts[0]);
          secondNumber = double.parse(parts[1]);
          double result;
          switch (operator) {
            case '/':
              result = firstNumber / secondNumber;
              break;
            case '*':
              result = firstNumber * secondNumber;
              break;
            case '-':
              result = firstNumber - secondNumber;
              break;
            case '+':
              result = firstNumber + secondNumber;
              break;
            default:
              result = 0;
          }
          display += "=$result";
          tfController.text = display; // Sonucu ekler ve TextField'ı günceller
          operator = '';
        }
      }
    });
  }

  void onClearPress() {
    setState(() {
      display = '';
      tfController.clear();
      operator = '';
      firstNumber = 0;
      secondNumber = 0;
    });
  }

  void onPercentagePress() {
    setState(() {
      if (display.isNotEmpty) {
        double number = double.parse(display);
        double result = number / 100;
        display = result.toString();
        tfController.text = display;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hesap Makinesi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tfController,
              decoration: const InputDecoration(hintText: "Sayı girin"),
              keyboardType: TextInputType.number,
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onClearPress,
                  child: const Text(
                    "AC",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPercentagePress,
                  child: const Text(
                    "%",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              _buildNumberButton('7'),
                              _buildNumberButton('8'),
                              _buildNumberButton('9'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              _buildNumberButton('4'),
                              _buildNumberButton('5'),
                              _buildNumberButton('6'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              _buildNumberButton('1'),
                              _buildNumberButton('2'),
                              _buildNumberButton('3'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              _buildNumberButton('0'),
                              _buildNumberButton('.'),
                              _buildNumberButton('C', clear: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildOperatorButton('/'),
                        _buildOperatorButton('*'),
                        _buildOperatorButton('-'),
                        _buildOperatorButton('+'),
                        _buildOperatorButton('=', isEqual: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, {bool clear = false}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (clear) {
            setState(() {
              display = '';
              tfController.clear();
            });
          } else {
            onNumberPress(number);
          }
        },
        child: Text(
          number,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String oper, {bool isEqual = false}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: isEqual ? onEqualPress : () => onOperatorPress(oper),
        child: Text(
          oper,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}