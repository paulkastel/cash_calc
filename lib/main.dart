import 'package:cash_calc/utils/app_routes.dart';
import 'package:cash_calc/views/main_view.dart';
import 'package:cash_calc/views/settings_page_view.dart';
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
        routes: {
          AppRoutes.settingsNav: (context) => SettingsPageView(),
        },
        title: 'Cash Calculator',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'Barlow',
        ),
        home: MainPageView());
  }
}
