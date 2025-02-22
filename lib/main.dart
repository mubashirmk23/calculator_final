import 'package:flutter/material.dart';
import 'package:flutter_calculatorpage_/calculatorpage1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculatorpage1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
