import 'package:cash_calc/blocs/currency_bloc.dart';
import 'package:cash_calc/models/currency_model.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/utils/app_texts.dart';
import 'package:cash_calc/views/components/dropdown_picker_cash.dart';
import 'package:cash_calc/views/currency_details_view.dart';
import 'package:cash_calc/views/gradient_decoration.dart';
import 'package:flutter/material.dart';

class CurrenciesView extends StatefulWidget {
  @override
  _CurrenciesViewState createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 800),
    ));
  }

  void _navigateToShowRateDetail(Currency item) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secAnimation) =>
            CurrencyDetailsView(item),
        transitionsBuilder: (context, animation, secAnimation, child) {
          return SlideTransition(
            child: child,
            position: animation.drive(
                Tween(begin: const Offset(1, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeOutQuart))),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    final _moneyBloc = BlocProvider.of<CurrencyBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: AppTexts.of(context).searchForCurrencies,
        onPressed: () {},
        child: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: appGradient,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: DropdownPickerCash((Currency selected) {
                if (_moneyBloc.addFavCurrency(selected)) {
                  _showSnackBar(
                      context,
                      AppTexts.of(context).startObserveNowCurrency +
                          ': ${selected.name}.');
                }
              }),
            ),
            Expanded(
              child: StreamBuilder<List<Currency>>(
                  stream: _moneyBloc.outFavCurrencyList,
                  initialData: _moneyBloc.favCurrencies,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Currency>> snapshot) {
                    return snapshot.data.isEmpty
                        ? Text(AppTexts.of(context).notFollowCurrencies)
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
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
                                        textAlign: TextAlign.center,
                                        style:
                                            Theme.of(context).textTheme.title,
                                      ),
                                    ),
                                    title: Hero(
                                        tag:
                                            'CodeDetail${items[index].isoCode}',
                                        child: Material(
                                            color: Colors.transparent,
                                            child: Text(items[index].isoCode))),
                                    subtitle: Text(items[index].name),
                                    onTap: () =>
                                        _navigateToShowRateDetail(items[index]),
                                    onLongPress: () {
                                      if (_moneyBloc
                                          .removeFavCurrency(items[index])) {
                                        _showSnackBar(
                                            context,
                                            AppTexts.of(context)
                                                    .stopObserveNowCurrency +
                                                ': ${items[index].name}.');
                                      }
                                    }),
                              );
                            },
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
