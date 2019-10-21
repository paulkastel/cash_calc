import 'package:cash_calc/repositories/api_handler.dart';
import 'package:cash_calc/repositories/db_handler.dart';
import 'package:cash_calc/utils/app_colors.dart';
import 'package:cash_calc/utils/app_routes.dart';
import 'package:cash_calc/utils/app_texts.dart';
import 'package:cash_calc/views/main_view.dart';
import 'package:cash_calc/views/settings_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  dbHandler = DbHandler();
  apiHandler = ApiHandler();
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
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: TextStyle(
                  color: AppColors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
            ),
          ),
          textTheme: TextTheme(
            title: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25),
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
        localizationsDelegates: [
          const AppTextsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('de', 'DE'),
          Locale('pl', 'PL')
        ],
        home: MainPageView());
  }
}
