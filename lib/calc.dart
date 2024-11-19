import 'dart:async';

import 'package:calculator/provider/calc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class myCalc extends StatefulWidget{
  const myCalc({super.key});
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<myCalc> {

  Map<String, bool> buttonStates = {};
  void handleTap(String txt){
     setState(() {
       buttonStates[txt] = true;

     });
     Provider.of<CalcProvider>(context, listen:false).setValue(txt);
     Timer(const Duration(milliseconds: 350), (){
      setState(() {
        buttonStates[txt] = false;
      });
     });
  }

  @override
  Widget build(BuildContext context){
    return Consumer<CalcProvider>(builder: (context, provider,_){
      return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: provider.historyDisplay
                        .map((entry) => Text(
                              entry,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ))
                        .toList(),
                  ),
                    ),
              ), 
            
             Flexible(
               child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    provider.screenText,
                    textAlign: TextAlign.right, // Adjust alignment for better scaling
                    style: const TextStyle(
                      fontSize: 100,
                      color: Colors.white,
                    ),
                ),
                           ),
                         ),
             ),
             const Spacer(),

    
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                numericButton(Colors.grey[400]!, "AC", Colors.black87),
                numericButton(Colors.grey[400]!, "+/-", Colors.black87),
                numericButton(Colors.grey[400]!, "%", Colors.black87),
                numericButton(Colors.amber[800]!, "/", Colors.white),
              ],
              
              ),
            ),
              const SizedBox(height: 10),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                numericButton(Colors.grey[800]!, "7",  Colors.white),
                numericButton(Colors.grey[800]!, "8",  Colors.white),
                numericButton(Colors.grey[800]!, "9",  Colors.white),
                numericButton(Colors.amber[800]!, "x", Colors.white),
                          
                  ],
                ),
              ),
          
               const SizedBox(height: 10),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                numericButton(Colors.grey[800]!, "4",  Colors.white),
                numericButton(Colors.grey[800]!, "5",  Colors.white),
                numericButton(Colors.grey[800]!, "6",  Colors.white),
                numericButton(Colors.amber[800]!, "-", Colors.white),
                          
                  ],
                ),
              ),
               const SizedBox(height: 10),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                numericButton(Colors.grey[800]!, "1",  Colors.white),
                numericButton(Colors.grey[800]!, "2",  Colors.white),
                numericButton(Colors.grey[800]!, "3",  Colors.white),
                numericButton(Colors.amber[800]!, "+", Colors.white),
                          
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]!, shape: const StadiumBorder(), padding: const EdgeInsets.fromLTRB(35, 14, 128, 14)),
                    onPressed: ()=> handleTap("0"), 
                    child: const Text("0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),)),
                    numericButton(Colors.grey[800]!, ".", Colors.white),
                    numericButton(Colors.grey[800]!, "=", Colors.white),
                          
                          
                  ],
                ),
              )
            ],
          ),
  
       
      )
      ),
    );




    }
    );
     }
    
Widget numericButton(Color bKColor, String txt, Color txtColor) {
  bool isChange = buttonStates[txt] ?? false;
    return GestureDetector(
    onTap: () => handleTap(txt),
    child: Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChange?Colors.white38: bKColor,
      ),
      child: 
      Center(
        child: Text(
          txt, 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: txtColor ),),
      ),
    ),
    );
  }


}


