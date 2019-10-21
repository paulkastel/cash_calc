import 'dart:math';

import 'package:cash_calc/utils/app_texts.dart';
import 'package:cash_calc/views/components/textfield_cash.dart';
import 'package:flutter/material.dart';

class ExchangeMoneyView extends StatefulWidget {
  @override
  _ExchangeMoneyViewState createState() => _ExchangeMoneyViewState();
}

class _ExchangeMoneyViewState extends State<ExchangeMoneyView>
    with TickerProviderStateMixin {
  AnimationController _animationCtrlr;
  bool _flipDirection = true;
  final TextEditingController _txtEditCtrlr = TextEditingController();

  @override
  void dispose() {
    _animationCtrlr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationCtrlr = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
  }

  void animateIcon() {
    if (_flipDirection) {
      setState(() => _flipDirection = false);
      _animationCtrlr.forward();
    } else {
      _animationCtrlr.reverse();
      setState(() => _flipDirection = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(AppTexts.of(context).convertforeginCurrencyVal,
                style: Theme.of(context).textTheme.headline),
          ),
          TextFieldCash(_txtEditCtrlr, () {
            print(_txtEditCtrlr.text);
          }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(AppTexts.of(context).currencyRateOf + ' usd: 4.3',
                style: Theme.of(context).textTheme.headline),
          ),
          AnimatedBuilder(
              animation: _animationCtrlr,
              builder: (BuildContext context, Widget child) {
                return FlatButton(
                  padding: const EdgeInsets.all(15),
                  color: Theme.of(context).primaryColorDark,
                  splashColor: Theme.of(context).accentColor,
                  shape: CircleBorder(),
                  onPressed: () {
                    animateIcon();
                  },
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(2 *
                          pi *
                          Tween(begin: 0.0, end: 0.5)
                              .animate(CurvedAnimation(
                                  parent: _animationCtrlr,
                                  curve:
                                      Interval(0.0, 0.7, curve: Curves.ease)))
                              .value),
                    child: Icon(
                      Icons.import_export,
                      color: Theme.of(context).iconTheme.color,
                      size: 40,
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(AppTexts.of(context).valueText + ':'),
          ),
        ],
      ),
    );
  }
}
