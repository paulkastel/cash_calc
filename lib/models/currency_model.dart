class Currency {
  const Currency(this.isoCode, this.name, this.flag);

  final String flag;
  final String isoCode;
  final String name;
}

const List<Currency> currencies = [
  Currency('AUD', 'Australian dollar', '🇦🇺'),
  Currency('BGN', 'Bulgarian lev', '🇧🇬'),
  Currency('BRL', 'Brazilian real', '🇧🇷'),
  Currency('CAD', 'Canadian dollar', '🇨🇦'),
  Currency('CHF', 'Swiss franc', '🇨🇭'),
  Currency('CNY', 'Chinese yuan renminbi', '🇨🇳'),
  Currency('CZK', 'Czech koruna', '🇨🇿'),
  Currency('DKK', 'Danish krone', '🇩🇰'),
  Currency('EUR', 'Euro', '🇪🇺'),
  Currency('GBP', 'Pound sterling', '🇬🇧'),
  Currency('HRK', 'Croatian kuna', '🇭🇷'),
  Currency('HUF', 'Hungarian forint', '🇭🇺'),
  Currency('INR', 'Indian rupee', '🇮🇳'),
  Currency('ISK', 'Icelandic krona', '🇮🇸'),
  Currency('JPY', 'Japanese yen', '🇯🇵'),
  Currency('MXN', 'Mexican peso', '🇲🇽'),
  Currency('NOK', 'Norwegian krone', '🇳🇴'),
  Currency('PLN', 'Polish zloty', '🇵🇱'),
  Currency('RON', 'Romanian leu', '🇷🇴'),
  Currency('RUB', 'Russian rouble', '🇷🇺'),
  Currency('SEK', 'Swedish krona', '🇸🇪'),
  Currency('SGD', 'Singapore dollar', '🇸🇬'),
  Currency('THB', 'Thai baht', '🇹🇭'),
  Currency('TRY', 'Turkish lira', '🇹🇷'),
  Currency('USD', 'US dollar', '🇺🇸'),
  Currency('ZAR', 'South African rand', '🇿🇦'),
];
