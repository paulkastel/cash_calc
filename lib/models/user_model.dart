import 'package:cash_calc/models/currency_model.dart';

class User {
  Currency _baseCurrency;

  Currency get baseCurrency => _baseCurrency;

  set baseCurrency(Currency base) {
    if (base != null || base.isoCode.isNotEmpty) {
      _baseCurrency = base;
    }
  }
}
