import 'package:cash_calc/bloc/currency_bloc.dart';
import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/views/currency_details_view.dart';
import 'package:flutter/material.dart';

class CurrenciesView extends StatefulWidget {
  @override
  _CurrenciesViewState createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 800),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _moneyBloc = BlocProvider.of<CurrencyBloc>(context);
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: StreamBuilder<Currency>(
              stream: _moneyBloc.outSelectedCurrency,
              initialData: _moneyBloc.selectedCurrency,
              builder:
                  (BuildContext context, AsyncSnapshot<Currency> snapshot) {
                return DropdownButton<Currency>(
                  underline: const SizedBox(),
                  value: snapshot.data,
                  onChanged: (Currency selected) {
                    setState(() {
                      if (_moneyBloc.addFavCurrency(selected)) {
                        _showSnackBar(
                            context, 'You observe now: ${selected.name} rates');
                      }
                    });
                  },
                  items: currencies.map((Currency currency) {
                    return DropdownMenuItem<Currency>(
                      value: currency,
                      child: Text('${currency.flag} ${currency.name}',
                          style: Theme.of(context).textTheme.body1),
                    );
                  }).toList(),
                );
              },
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<List<Currency>>(
                stream: _moneyBloc.outFavCurrencyList,
                initialData: _moneyBloc.favCurrencies,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Currency>> snapshot) {
                  return snapshot.data.isEmpty
                      ? const Text('You don\'t follow any rate')
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final List<Currency> items =
                                snapshot.data.reversed.toList();
                            return Card(
                              color: Theme.of(context).primaryColorLight,
                              elevation: 2,
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        Theme.of(context).iconTheme.color,
                                    child: Text(
                                      items[index].flag,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  title: Text(items[index].isoCode),
                                  subtitle: Text(items[index].name),
                                  onTap: () {
                                    print(items[index].isoCode);
                                    Navigator.push<MaterialPageRoute>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CurrencyDetailsView(items[index]),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    _showSnackBar(context,
                                        'You stopped observing: ${items[index].name}');
                                    // setState(() => _moneyBloc
                                    //     .removeFavCurrency(items[index]));
                                  }),
                            );
                          },
                        );
                }),
          ),
        )
      ],
    );
  }
}
