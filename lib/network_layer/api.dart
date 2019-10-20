library api.x;

import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/models/user_model.dart';

ApiHandler api;

class ApiHandler {
  ApiHandler() {
    appUser = User(currencies[4]);
  }
  static const String httpAdress = 'https://api.exchangeratesapi.io/';
  User appUser;
}
