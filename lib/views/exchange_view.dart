import 'dart:math';

import 'package:cash_calc/blocs/currency_bloc.dart';
import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/utils/app_colors.dart';
import 'package:cash_calc/utils/app_texts.dart';
import 'package:cash_calc/views/components/dropdown_picker_cash.dart';
import 'package:cash_calc/views/components/textfield_cash.dart';
import 'package:flutter/material.dart';

class ExchangeMoneyView extends StatefulWidget {
  final CurrencyBloc _baseCBloc = CurrencyBloc();
  final CurrencyBloc _counterCBloc = CurrencyBloc();

  @override
  _ExchangeMoneyViewState createState() => _ExchangeMoneyViewState();
}

class _ExchangeMoneyViewState extends State<ExchangeMoneyView>
    with TickerProviderStateMixin {
  double currencyCalculatedOutput;
  Future<double> exchangeRate;
  double latestExchangeRate;

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
    currencyCalculatedOutput = 0;
    doRequest(_flipDirection);
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

  String outputCurrencyIsoCode(bool direction) {
    String currencyOutput = '';
    setState(() {
      currencyOutput = !direction
          ? widget._baseCBloc.selectedCurrency.isoCode
          : widget._counterCBloc.selectedCurrency.isoCode;
    });
    return currencyOutput;
  }

  Future<void> doRequest(bool direction) async {
    outputCurrencyIsoCode(_flipDirection);
    setState(() {
      if (direction) {
        exchangeRate = widget._baseCBloc
            .getCurrentRate(widget._counterCBloc.selectedCurrency.isoCode);
      } else {
        exchangeRate = widget._counterCBloc
            .getCurrentRate(widget._baseCBloc.selectedCurrency.isoCode);
      }
    });
    latestExchangeRate = await Future.value(exchangeRate);
  }

  void exchangeMoney(double rate) {
    final double value = double.tryParse(_txtEditCtrlr.text);
    setState(() {
      if (value != null) {
        currencyCalculatedOutput =
            widget._baseCBloc.performCashExchange(value, latestExchangeRate);
      } else {
        currencyCalculatedOutput = 0;
      }
      print('$value * $latestExchangeRate =  $currencyCalculatedOutput');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(AppTexts.of(context).convertforeginCurrencyVal,
                  style: Theme.of(context).textTheme.headline),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BlocProvider(
                  bloc: widget._baseCBloc,
                  child: DropdownPickerCash((Currency base) {
                    widget._baseCBloc.selectedCurrency = base;
                    doRequest(_flipDirection);
                    exchangeMoney(latestExchangeRate);
                  }, displayLongName: false),
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
                          doRequest(_flipDirection);
                          exchangeMoney(latestExchangeRate);
                          animateIcon();
                        },
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateY(2 *
                                pi *
                                Tween(begin: 0.0, end: 0.5)
                                    .animate(CurvedAnimation(
                                        parent: _animationCtrlr,
                                        curve: Interval(0.0, 0.7,
                                            curve: Curves.ease)))
                                    .value),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              color: Theme.of(context).iconTheme.color,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    }),
                BlocProvider(
                  bloc: widget._counterCBloc,
                  child: DropdownPickerCash((Currency counter) {
                    widget._counterCBloc.selectedCurrency = counter;
                    doRequest(_flipDirection);
                    exchangeMoney(latestExchangeRate);
                  }, displayLongName: false),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: FutureBuilder<double>(
                future: exchangeRate,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Text(
                          'Rate: ${snapshot.data.toStringAsFixed(4)}',
                          style: Theme.of(context).textTheme.body2,
                        ),
                        TextFieldCash(_txtEditCtrlr, () {
                          latestExchangeRate = snapshot.data;
                          exchangeMoney(latestExchangeRate);
                        }),
                      ],
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(AppTexts.of(context).valueText + ':',
                  style: Theme.of(context).textTheme.body2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 3,
                text: TextSpan(children: [
                  TextSpan(
                    text: currencyCalculatedOutput.toStringAsFixed(3),
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                      text: outputCurrencyIsoCode(_flipDirection),
                      style: TextStyle(color: AppColors.black))
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
