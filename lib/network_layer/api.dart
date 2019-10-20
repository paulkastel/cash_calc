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

  void updateBaseCurrency(Currency newMoney) {
    appUser.baseCurrency = newMoney;
  }

  void addUserFavouriteCurrency(Currency incomingMoney) {
    appUser.favesCurrencies.add(incomingMoney);
  }

  void deleteUserFavouriteCurrency(Currency favCurrency) {
    appUser.favesCurrencies.remove(favCurrency);
  }
}
