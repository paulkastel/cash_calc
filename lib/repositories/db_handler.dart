library api.app_database;

import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/models/user_model.dart';

DbHandler dbHandler;
// TODO: add sqlie
// TODO: add tests
class DbHandler {
  DbHandler() {
    appUser = User(currencies[4]);
  }
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
