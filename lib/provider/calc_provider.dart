import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalcProvider extends ChangeNotifier{
  String _screenText = '0';
  String get screenText => _screenText;
  final List<String> _historyDisplay = [];
  List<String> get historyDisplay => List.unmodifiable(_historyDisplay);
  final int _historyLimit = 2;

void setValue(String value) {
  if (value == "AC") {
    _screenText = "";
    _clearAll();
  } else if (_screenText == "0" && value != "=") {
    _screenText = value;
  } else {
    switch (value) {
      case "+/-":
        sign_change();
        break;  
      case 'x':
        _screenText += "x";
        break;
      case '=':
        perform_calculation();
        break;
      default:
        _screenText += value;
    }
  }
  notifyListeners();
}

  void perform_calculation(){
    try{
     String expression = _screenText.replaceAll("x", "*");
     num result = expression.interpret();
     _historyDisplay.add("$expression = ${result.toString()}");
     if(_historyDisplay.length > _historyLimit){
      _historyDisplay.removeAt(0);
     }
     _screenText = result == result.toInt() ? result.toInt().toString(): result.toString();
    } catch (e){
      _screenText = "Error";
    }

    notifyListeners();
  }


  void sign_change(){

    int lastOperatorIndex = _screenText.lastIndexOf(RegExp(r'[+\-*/]'));
    String lastNumber = _screenText.substring(lastOperatorIndex + 1);

     if (lastNumber.isNotEmpty) {
      if (lastNumber.startsWith('-')) {
        _screenText = _screenText.substring(0, lastOperatorIndex + 1) + lastNumber.substring(1);
      } else {
        _screenText = '${_screenText.substring(0, lastOperatorIndex + 1)}-$lastNumber';
      }
    }
    notifyListeners();
  }

    void _clearAll() {
    _screenText = "0";
    _historyDisplay.clear();
  }



}


