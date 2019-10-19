import 'package:cash_calc/models/currency_model.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyDetailsView extends StatelessWidget {
  const CurrencyDetailsView(this.currency);

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).iconTheme.color,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          currency.isoCode,
        ),
      ),
      body: Text(
        'Details of ${currency.name}',
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
