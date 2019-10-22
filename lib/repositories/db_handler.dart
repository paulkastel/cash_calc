library api.app_database;

import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

DbHandler dbHandler;

// TODO: add sqlie
// TODO: add tests
class DbHandler {
  DbHandler() {
    appUser = User(currencies[17]);
  }

  User appUser;

  /// TODO: this databse is needed to be finished, think about some good db structure
  Future<void> _initializeAppDataBase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'cash_calc.db'),
      version: 1,
    );
  }

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
