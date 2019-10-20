import 'package:cash_calc/models/currency_model.dart';

class User {
  User(this._baseCurrency);
  Currency _baseCurrency;

  Currency get baseCurrency => _baseCurrency;

  set baseCurrency(Currency base) {
    if (base != null || base.isoCode.isNotEmpty) {
      _baseCurrency = base;
    }
  }

  final List<Currency> _favouriteCurrencies = List<Currency>();

  List<Currency> get favesCurrencies => _favouriteCurrencies;
}
