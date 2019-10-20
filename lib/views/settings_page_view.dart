import 'package:cash_calc/blocs/currency_bloc.dart';
import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/views/components/dropdown_picker_cash.dart';
import 'package:flutter/material.dart';

@immutable
class SettingsPageView extends StatefulWidget {
  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    final CurrencyBloc _moneyBloc = BlocProvider.of<CurrencyBloc>(context);
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
                DropdownPickerCash(
                    (Currency selected) =>
                        _moneyBloc.changeUserBaseCurrency(selected),
                    displayLongName: false)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
