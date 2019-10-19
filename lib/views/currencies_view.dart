import 'package:flutter/material.dart';

class CurrenciesView extends StatefulWidget {
  @override
  _CurrenciesViewState createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('show current stock',
          style: Theme.of(context).textTheme.headline),
    );
  }
}
