import 'package:cash_calc/models/currency_model.dart';
import 'package:flutter/material.dart';

@immutable
class SettingsPageView extends StatefulWidget {
  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  Currency _selectedCurrency = currencies[0];

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
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'You are in settings',
            style: Theme.of(context).textTheme.body1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text('Select base currency: '),
                DropdownButton<Currency>(
                  underline: const SizedBox(),
                  value: _selectedCurrency,
                  onChanged: (Currency selected) {
                    setState(() {
                      _selectedCurrency = selected;
                    });
                  },
                  items: currencies.map((Currency currency) {
                    return DropdownMenuItem<Currency>(
                      value: currency,
                      child: Text('${currency.flag} ${currency.isoCode}',
                          style: Theme.of(context).textTheme.body1),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
