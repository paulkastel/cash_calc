import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cash_calc/l10n/messages_all.dart';

class AppTexts {
  AppTexts(this.localeName);

  final String localeName;

  static Future<AppTexts> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppTexts(localeName);
    });
  }

  static AppTexts of(BuildContext context) {
    return Localizations.of<AppTexts>(context, AppTexts);
  }

  String get settingsText {
    return Intl.message(
      'Settings',
      name: 'settingsText',
      desc: 'Title for settings menu',
      locale: localeName,
    );
  }

  String get notFollowCurrencies {
    return Intl.message(
      'You don\'t follow any currencies',
      name: 'notFollowCurrencies',
      desc: 'Info that user do not observe any currency rates',
      locale: localeName,
    );
  }

  String get convertforeginCurrencyVal {
    return Intl.message(
      'Convert foregin currency value',
      name: 'convertforeginCurrencyVal',
      desc: 'Header: Check exchange rate',
      locale: localeName,
    );
  }

  String get currencyRateOf {
    return Intl.message(
      'Currency rate of',
      name: 'currencyRateOf',
      desc: 'Info about rate',
      locale: localeName,
    );
  }

  String get valueText {
    return Intl.message(
      'Value',
      name: 'valueText',
      desc: 'Estimate the monetary worth of',
      locale: localeName,
    );
  }

  String get searchForCurrencies {
    return Intl.message(
      'Search for currencies',
      name: 'searchForCurrencies',
      desc: 'Look out for currencies rate',
      locale: localeName,
    );
  }

  String get calculationText {
    return Intl.message(
      'Calculator',
      name: 'calculationText',
      desc: 'Title calculator menu',
      locale: localeName,
    );
  }

  String get currencies {
    return Intl.message(
      'Currencies',
      name: 'currencies',
      desc: 'Title for currencies menu',
      locale: localeName,
    );
  }

  String get selectBaseCurrencyText {
    return Intl.message(
      'Select base currency',
      name: 'selectBaseCurrencyText',
      desc: 'User orgin currency, from rate is count',
      locale: localeName,
    );
  }

  String get startObserveNowCurrency {
    return Intl.message(
      'You observe now',
      name: 'startObserveNowCurrency',
      desc: 'Info: user is now following exchange rate',
      locale: localeName,
    );
  }

  String get stopObserveNowCurrency {
    return Intl.message(
      'You stopped observing',
      name: 'stopObserveNowCurrency',
      desc: 'Info: user is stopped following exchange rate',
      locale: localeName,
    );
  }
}

class AppTextsDelegate extends LocalizationsDelegate<AppTexts> {
  const AppTextsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'pl'].contains(locale.languageCode);

  @override
  Future<AppTexts> load(Locale locale) => AppTexts.load(locale);

  @override
  bool shouldReload(AppTextsDelegate old) => false;
}
