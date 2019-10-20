import 'package:cash_calc/bloc/currency_bloc.dart';
import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:flutter/material.dart';

@immutable
class DropdownPickerCash extends StatelessWidget {
  const DropdownPickerCash(this.onChangedCurrency,
      {this.displayLongName = true})
      : assert(onChangedCurrency != null);

  final Function(Currency choosenCurrency) onChangedCurrency;
  final bool displayLongName;
  @override
  Widget build(BuildContext context) {
    final CurrencyBloc _moneyBloc = BlocProvider.of<CurrencyBloc>(context);
    return StreamBuilder<Currency>(
      stream: _moneyBloc.outSelectedCurrency,
      initialData: _moneyBloc.selectedCurrency,
      builder: (BuildContext context, AsyncSnapshot<Currency> snapshot) {
        return DropdownButton<Currency>(
          underline: const SizedBox(),
          value: snapshot.data,
          onChanged: onChangedCurrency,
          items: currencies.map((Currency currency) {
            return DropdownMenuItem<Currency>(
              value: currency,
              child: displayLongName
                  ? Text('${currency.flag} ${currency.name}',
                      style: Theme.of(context).textTheme.body1)
                  : Text('${currency.flag} ${currency.isoCode}',
                      style: Theme.of(context).textTheme.body1),
            );
          }).toList(),
        );
      },
    );
  }
}
