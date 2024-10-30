import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalcProvider extends ChangeNotifier{
  String _screenText = '0';
  String get screenText => _screenText;
  String _historyDisplay = '';
  String get historyDisplay => _historyDisplay;
  final int _historyLimit = 20;

  void setValue(String value){
    if(_screenText == "0" && value != "="){
      _screenText = value;
      _historyDisplay = value;
    }
    else{
      switch(value){
        case"AC":
          _screenText = "0";
          _historyDisplay = '';
          break;
        case "+/-":
          sign_change();
          break;  
        case'x':
          _screenText += "*";
          _historyDisplay += ' x ';
          break;
        case '=':
          perform_calculation();
          break;
          default:
          _screenText += value;
          _historyDisplay += value ;
      }
    }
    _historyDisplayLength();
    notifyListeners();
  }

  void perform_calculation(){
    try{
     String expression = _screenText.replaceAll("x", "*");
     num result = expression.interpret();
     _historyDisplay = "$_historyDisplay";
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
        _screenText = _screenText.substring(0, lastOperatorIndex + 1) + '-' + lastNumber;
      }
    }
    notifyListeners();
  }


 void _historyDisplayLength(){
   if (_historyDisplay.length > _historyLimit) {
      _historyDisplay = _historyDisplay.substring(_historyDisplay.length - _historyLimit);
    }
 }
}


