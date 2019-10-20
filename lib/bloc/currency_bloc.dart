import 'dart:async';

import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/network_layer/api.dart';
import 'package:cash_calc/services/bloc_provider.dart';

class CurrencyBloc implements BlocBase {
  CurrencyBloc() {
    _streamSettingBaseCurrency.stream.listen(changeUserBaseCurrency);
  }

  final StreamController<Currency> _streamCurrencyCtrlr =
      StreamController<Currency>.broadcast();

  final StreamController<Currency> _streamSettingBaseCurrency =
      StreamController<Currency>();

  @override
  void dispose() {
    _streamCurrencyCtrlr.close();
  }

  Stream<Currency> get outStreamCurrencyCtrlr =>
      _streamCurrencyCtrlr.stream.asBroadcastStream();

  Sink<Currency> get _inSettingCtrlr => _streamCurrencyCtrlr.sink;

  void changeUserBaseCurrency(Currency newMoney) {
    print('BASE: ${newMoney.isoCode}');
    _inSettingCtrlr.add(newMoney);
    api.appUser.baseCurrency = newMoney;
  }

  void addNewFavCurrency(Currency newFavCurrency) {
    _inSettingCtrlr.add(newFavCurrency);
    if (!api.appUser.favesCurrencies.contains(newFavCurrency)) {
      api.appUser.favesCurrencies.add(newFavCurrency);
    }

    print('State of favs: ${api.appUser.favesCurrencies.toList().toString()}');
  }
}
