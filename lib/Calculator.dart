class Calculator {
  
  Operation _operation;

  void addOperator(Operation operation) {
    this._operation = operation;
  }
  bool hasOperation() {
    return _operation != null;
  }
  double performOperation(double secondValue) {
    return _operation.perform(secondValue);
  }
  void reset() {
    this._operation = null;
  }
}


abstract class Operation {
  double _firstValue;
  Operation(this._firstValue);
  double perform(double anotherValue); 
}

 class AddOperation extends Operation {
  AddOperation(double firstValue) : super(firstValue);
  @override
  double perform(double anotherValue) {
    return _firstValue + anotherValue;
  }
}

class SubtractionOperation extends Operation {
  SubtractionOperation(double firstValue) : super(firstValue);
  @override
  double perform(double anotherValue) {
    return _firstValue - anotherValue;
  }
}