import 'package:cash_calc/views/components/textfield_cash.dart';
import 'package:flutter/material.dart';

class ExchangeMoneyView extends StatefulWidget {
  @override
  _ExchangeMoneyViewState createState() => _ExchangeMoneyViewState();
}

class _ExchangeMoneyViewState extends State<ExchangeMoneyView> {
  TextEditingController txtEditCtrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('how many dolars are euro',
            style: Theme.of(context).textTheme.headline),
        TextFieldCash(txtEditCtrlr, () {
          print(txtEditCtrlr.text);
        }),
        Text('Currancy rate of usd: 4.3',
            style: Theme.of(context).textTheme.headline),
        FlatButton(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).primaryColorDark,
          splashColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.import_export,
            color: Theme.of(context).iconTheme.color,
            size: 60,
          ),
          shape: CircleBorder(),
          onPressed: () {
            print('fuck');
          },
        ),
        const Text('your output is'),
      ],
    );
  }
}
