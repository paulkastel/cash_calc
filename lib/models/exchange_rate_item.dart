class ExchangeRateItem {
  ExchangeRateItem(
      {this.rates, this.base, this.date, this.startAt, this.endAt});

  factory ExchangeRateItem.fromJsonHistorical(dynamic jsonResponse) {
    return ExchangeRateItem(
      rates: jsonResponse['rates'] as Map<String, dynamic>,
      base: jsonResponse['base'] as String,
      date: DateTime.parse(jsonResponse['date'] as String),
      startAt: DateTime.parse(jsonResponse['start_at'] as String),
      endAt: DateTime.parse(jsonResponse['end_at'] as String),
    );
  }

  factory ExchangeRateItem.fromJsonLatest(dynamic jsonResponse) {
    return ExchangeRateItem(
      rates: jsonResponse['rates'] as Map<String, dynamic>,
      base: jsonResponse['base'] as String,
      date: DateTime.parse(jsonResponse['date'] as String),
      startAt: DateTime.parse(jsonResponse['date'] as String),
      endAt: DateTime.parse(jsonResponse['date'] as String),
    );
  }

  final String base;
  final DateTime date;
  final DateTime endAt;
  final Map<String, dynamic> rates;
  final DateTime startAt;
}