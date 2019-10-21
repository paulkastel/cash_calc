import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/models/exchange_rate_item.dart';
import 'package:cash_calc/repositories/api_handler.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyDetailsView extends StatefulWidget {
  const CurrencyDetailsView(this.currency);

  final Currency currency;

  @override
  _CurrencyDetailsViewState createState() => _CurrencyDetailsViewState();
}

class _CurrencyDetailsViewState extends State<CurrencyDetailsView> {
  Future<ExchangeRateItem> exchangeData;

  @override
  void initState() {
    exchangeData = apiHandler.fetchAllRatesLatest(widget.currency.isoCode);
    super.initState();
  }

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
        title: Hero(
          tag: 'CodeDetail${widget.currency.isoCode}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.currency.isoCode,
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<ExchangeRateItem>(
          future: exchangeData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  itemCount: snapshot.data.rates.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      title: Text(
                          snapshot.data.rates.values.elementAt(i).toString()),
                      trailing: Text(snapshot.data.rates.keys.elementAt(i)),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
