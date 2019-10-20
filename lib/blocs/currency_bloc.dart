import 'dart:async';

import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/network_layer/api.dart';
import 'package:cash_calc/services/bloc_provider.dart';

class CurrencyBloc implements BlocBase {
  CurrencyBloc() {
    selectedCurrency = currencies[0];
    favCurrencies = List<Currency>();
    getDataFromApi();
  }

  List<Currency> favCurrencies;

  Currency _selCurrency;

  Currency get selectedCurrency => _selCurrency;

  set selectedCurrency(Currency val) {
    if (val != null) {
      _selCurrency = val;
      _inSelectedCurrency.add(val);
    }
  }

  final _favCurrenciesController = StreamController<List<Currency>>.broadcast();
  Sink<List<Currency>> get _inFavCurrencyList => _favCurrenciesController.sink;

  Stream<List<Currency>> get outFavCurrencyList =>
      _favCurrenciesController.stream.asBroadcastStream();

  final _selectedCurrencyController = StreamController<Currency>.broadcast();

  Sink<Currency> get _inSelectedCurrency => _selectedCurrencyController.sink;

  Stream<Currency> get outSelectedCurrency =>
      _selectedCurrencyController.stream.asBroadcastStream();

  @override
  void dispose() {
    _favCurrenciesController?.close();
    _selectedCurrencyController?.close();
  }

  void changeUserBaseCurrency(Currency money) {
    selectedCurrency = money;
    api.updateBaseCurrency(money);
  }

  bool addFavCurrency(Currency favCurrency) {
    if (!favCurrencies.contains(favCurrency)) {
      selectedCurrency = favCurrency;
      _inFavCurrencyList.add(favCurrencies);
      api.addUserFavouriteCurrency(favCurrency);
      return true;
    } else {
      return false;
    }
  }

  bool removeFavCurrency(Currency favCurrency) {
    if (favCurrencies.contains(favCurrency)) {
      _inFavCurrencyList.add(favCurrencies);
      api.deleteUserFavouriteCurrency(favCurrency);
      return true;
    } else {
      return false;
    }
  }

  void getDataFromApi() {
    selectedCurrency = api.appUser.baseCurrency;
    favCurrencies = api.appUser.favesCurrencies;
  }
}
