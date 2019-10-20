import 'package:cash_calc/network_layer/api.dart';
import 'package:cash_calc/utils/app_colors.dart';
import 'package:cash_calc/utils/app_routes.dart';
import 'package:cash_calc/views/main_view.dart';
import 'package:cash_calc/views/settings_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  api = ApiHandler();
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
          primaryColor: AppColors.darkGreen,
          backgroundColor: AppColors.olive,
          accentColor: AppColors.green,
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
          textTheme: TextTheme(
            title: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 29),
            headline: TextStyle(
                color: AppColors.black,
                fontSize: 22.0,
                fontStyle: FontStyle.italic),
            subhead: TextStyle(
                color: AppColors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
            body1: TextStyle(color: AppColors.black, fontSize: 18.0),
          ),
          fontFamily: 'Barlow',
        ),
        home: MainPageView());
  }
}
