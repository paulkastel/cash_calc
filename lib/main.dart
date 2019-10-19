import 'package:cash_calc/views/main_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CashCalcApp());
}

class CashCalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Cash Calculator',
      theme: ThemeData(primarySwatch: Colors.lightGreen, fontFamily: 'Barlow'),
      home: MainPageView()
    );
  }
}
