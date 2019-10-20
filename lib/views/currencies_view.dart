import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/views/currency_details_view.dart';
import 'package:flutter/material.dart';

class CurrenciesView extends StatefulWidget {
  @override
  _CurrenciesViewState createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  List<Currency> _favouriteCurrencies;
  Currency _selectedCurrency = currencies[0];

  @override
  void initState() {
    _favouriteCurrencies ??= List<Currency>();
    super.initState();
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 800),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: DropdownButton<Currency>(
            underline: const SizedBox(),
            value: _selectedCurrency,
            onChanged: (Currency selected) {
              setState(() {
                if (!_favouriteCurrencies.contains(selected)) {
                  _favouriteCurrencies.add(selected);
                  _selectedCurrency = selected;
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
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: _favouriteCurrencies.isEmpty
                ? const Text('You don\'t follow any rate')
                : ListView.builder(
                    itemCount: _favouriteCurrencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Theme.of(context).primaryColorLight,
                        elevation: 2,
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Theme.of(context).iconTheme.color,
                              child: Text(
                                _favouriteCurrencies[index].flag,
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            title: Text(_favouriteCurrencies[index].isoCode),
                            subtitle: Text(_favouriteCurrencies[index].name),
                            onTap: () {
                              print(_favouriteCurrencies[index].isoCode);
                              Navigator.push<MaterialPageRoute>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CurrencyDetailsView(
                                      _favouriteCurrencies[index]),
                                ),
                              );
                            },
                            onLongPress: () {
                              _showSnackBar(context,
                                  'You stopped observing: ${_favouriteCurrencies[index].name}');
                              setState(
                                  () => _favouriteCurrencies.removeAt(index));
                            }),
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
