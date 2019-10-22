library api.app_network;

import 'dart:convert';
import 'dart:io';

import 'package:cash_calc/models/exchange_rate_item.dart';
import 'package:http/http.dart' as http;

ApiHandler apiHandler;

class ApiHandler {
  static const String httpAddress = 'https://api.exchangeratesapi.io/';
  static const int successfullConnection = 200;

  Future<ExchangeRateItem> fetchAllRatesLatest(String baseCurrency) async {
    try {
      if (baseCurrency.isEmpty) {
        throw const FormatException(
            'Base currency code must contain proper value!');
      }
      final http.Response response = await http
          .get(Uri.encodeFull(httpAddress + 'latest?base=$baseCurrency'));
      if (response.statusCode == successfullConnection) {
        //print(json.decode(response.body));
        return ExchangeRateItem.fromJsonLatest(json.decode(response.body));
      } else {
        throw const HttpException('Connection failed!');
      }
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    }
  }

  Future<ExchangeRateItem> fetchAllRatesSpecificDate(
      DateTime date, String baseCurrency) async {
    try {
      if (baseCurrency.isEmpty) {
        throw const FormatException(
            'Base currency code must contain proper value!');
      }
      //TODO: validation, date no older than 1999 and newer than today, check date.tostring format
      final http.Response response = await http.get(Uri.encodeFull(
          httpAddress + '${date.toString()}?base=$baseCurrency'));
      if (response.statusCode == successfullConnection) {
        //print(json.decode(response.body));
        return ExchangeRateItem.fromJsonLatest(json.decode(response.body));
      } else {
        throw const HttpException('Connection failed!');
      }
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    }
  }

  Future<ExchangeRateItem> fetchSpecificRateAtSpecificDate(
      String baseCurrency, String counterCurrency, DateTime date) async {
    try {
      if (baseCurrency.isEmpty || counterCurrency.isEmpty) {
        throw const FormatException(
            'Base currency code must contain proper value!');
      }
      //TODO: validation, date no older than 1999, check date.tostring format
      final http.Response response = await http.get(Uri.encodeFull(httpAddress +
          '${date.toString()}' +
          '?base=$baseCurrency' +
          '&symbols=$counterCurrency'));
      if (response.statusCode == successfullConnection) {
        //print(json.decode(response.body));
        return ExchangeRateItem.fromJsonLatest(json.decode(response.body));
      } else {
        throw const HttpException('Connection failed!');
      }
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    }
  }

  Future<ExchangeRateItem> fetchSpecificRateAtLatest(
      String baseCurrency, String counterCurrency) async {
    try {
      if (baseCurrency.isEmpty || counterCurrency.isEmpty) {
        throw const FormatException(
            'Base currency code must contain proper value!');
      }
      final http.Response response = await http.get(Uri.encodeFull(httpAddress +
          'latest?base=$baseCurrency' +
          '&symbols=$counterCurrency'));

      if (response.statusCode == successfullConnection) {
        return ExchangeRateItem.fromJsonLatest(json.decode(response.body));
      } else {
        throw const HttpException('Connection failed!');
      }
    } on HandshakeException {
      throw 'Error estabishing connection';
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    }
  }

  Future<ExchangeRateItem> fetchSpecificHistoryForSpecificRate(
      String baseCurrency,
      String counterCurrency,
      DateTime startAt,
      DateTime endAt) async {
    try {
      if (baseCurrency.isEmpty || counterCurrency.isEmpty) {
        throw const FormatException(
            'Base currency code must contain proper value!');
      }
      // TODO: set dates from strings
      final http.Response response = await http.get(Uri.encodeFull(httpAddress +
          'history?start_at=2018-01-01&end_at=2018-09-01' +
          '&base=$baseCurrency' +
          '&symbols=$counterCurrency'));

      if (response.statusCode == successfullConnection) {
        return ExchangeRateItem.fromJsonHistorical(json.decode(response.body));
      } else {
        throw const HttpException('Connection failed!');
      }
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    }
  }
}
