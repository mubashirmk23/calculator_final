import 'package:flutter/material.dart';

class Calculatorpage1 extends StatefulWidget {
  @override
  State<Calculatorpage1> createState() => _StatefulWidget();
}

class _StatefulWidget extends State<Calculatorpage1> {
  dynamic text = '0';
  String currentInput = '';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '0';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget calcbutton(
    String btntxt,
    Color btncolor,
    Color txtcolor,
  ) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 25,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Calculator',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      currentInput,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                // Button rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbutton('AC', Colors.grey, Colors.black),
                    calcbutton('+/-', Colors.grey, Colors.black),
                    calcbutton('%', Colors.grey, Colors.black),
                    calcbutton('/', Colors.amber, Colors.white),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbutton('7', Colors.grey, Colors.white),
                    calcbutton('8', Colors.grey, Colors.white),
                    calcbutton('9', Colors.grey, Colors.white),
                    calcbutton('*', Colors.amber, Colors.white),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbutton('4', Colors.grey, Colors.white),
                    calcbutton('5', Colors.grey, Colors.white),
                    calcbutton('6', Colors.grey, Colors.white),
                    calcbutton('-', Colors.amber, Colors.white),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbutton('1', Colors.grey, Colors.white),
                    calcbutton('2', Colors.grey, Colors.white),
                    calcbutton('3', Colors.grey, Colors.white),
                    calcbutton('+', Colors.amber, Colors.white),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () {
                          calculation('0');
                        },
                        child: Text(
                          '0',
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ),
                    ),
                    calcbutton('.', Colors.grey, Colors.white),
                    calcbutton('=', Colors.amber, Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void calculation(String btnText) {
    if (btnText != 'AC' && btnText != '=') {
      if (isOperator(btnText) && currentInput.isNotEmpty && isOperator(currentInput[currentInput.length - 1])) {
        currentInput = currentInput.substring(0, currentInput.length - 1) + btnText;
      } else {
        currentInput += btnText;
      }
    } else if (btnText == 'AC') {
      currentInput = '';
    } else if (btnText == '=') {
      currentInput += btnText;
    }

    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (btnText == '=' && opr.isNotEmpty) {
      numTwo = double.parse(result);
      handleOperation(opr);
      opr = '';
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '*' ||
        btnText == '%' ||
        btnText == '/') {
      if (result.isNotEmpty) {
        if (numOne == 0) {
          numOne = double.parse(result);
        } else {
          numTwo = double.parse(result);
          handleOperation(opr);
        }
      }
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      if (numOne != 0) {
        result = (numOne / 100).toString();
        finalResult = doesContainDecimal(result);
      } else {
        // Handle empty result for '%'
        finalResult = '0'; // Or display an error message as needed
      }
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      if (result.toString().startsWith('-')) {
        result = result.toString().substring(1);
      } else {
        result = '-' + result.toString();
      }
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  bool isOperator(String btnText) {
    return btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/' || btnText == '%';
  }

  void handleOperation(String operation) {
    if (operation == '+') {
      finalResult = add();
    } else if (operation == '-') {
      finalResult = sub();
    } else if (operation == '*') {
      finalResult = mul();
    } else if (operation == '/') {
      finalResult = div();
    }
    numTwo = 0;
    result = '';
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) {
      return "Error";
    }
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (int.parse(splitDecimal[1]) == 0) {
        return splitDecimal[0];
      }
    }
    return result.toString();
  }
}