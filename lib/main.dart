import 'package:calculator/provider/calc_provider.dart';
import 'package:flutter/material.dart';
import 'package:calculator/calc.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

    create: (context) => CalcProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const myCalc(), 
      ),
    );
    
    
  }
}

