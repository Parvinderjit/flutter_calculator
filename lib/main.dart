import 'package:basic_calculator/Calculator.dart';
import 'package:flutter/material.dart';
import 'ButtonsWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _calculator = Calculator();
  var _textController = TextEditingController();
  String text;

  void _buttonTapped(String text) {
    if(["/","X","-","+","%"].contains(text)) {
      handleOperator(text);
    }
    else if(text == "=") {
      performOperation();
    }
    else if (text.toLowerCase() == "ac") {
      _resetCalculator();
    }
    else {
      handleDigits(text);
    }
  } 

  void _resetCalculator() {
    _calculator.reset();
    _textController.text = "";
  }

  Operation getOperationFrom(String opCode) {
    double value = double.parse(_textController.text);
    switch (opCode) {
      case "+":
         return AddOperation(value);   
        break;
      default:
    }
    return null;
  }

  void handleDigits(String digit){
    if(digit == "." && _textController.text.contains(digit)){ return;}
    if(_calculator.hasOperation()) {
      _textController.text = "";
    }
    _textController.text += digit;
  }

  void performOperation() {
      if (_calculator.hasOperation()) {
        _textController.text =  _calculator.performOperation(_doubleValue).toString();
      }
  }

  double get _doubleValue {
    return double.parse(_textController.text);
  }

  void handleOperator(String op) {
    
    if(_calculator.hasOperation()) {
      this.performOperation();
    }

    switch (op) {
      case "+":
          _calculator.addOperator(AddOperation(_doubleValue));
        break;
      case "-":
        _calculator.addOperator(SubtractionOperation(_doubleValue));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var height = constraints.maxHeight * 0.3;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                      ),
                      controller: _textController,
                      cursorColor: Colors.grey,
                      focusNode: FocusNode(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ButtonsWidget(_buttonTapped),
              )
            ],
          );
        },
      ),
    );
  }
}
