import 'package:cash_calc/blocs/currency_bloc.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/utils/app_texts.dart';
import 'package:cash_calc/views/currencies_view.dart';
import 'package:cash_calc/views/exchange_view.dart';
import 'package:cash_calc/views/gradient_decoration.dart';
import 'package:cash_calc/views/settings_page_view.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final List<Widget> _children = [
    ExchangeMoneyView(),
    BlocProvider(child: CurrenciesView(), bloc: CurrencyBloc()),
  ];

  final PageController _pageCtrlr = PageController(initialPage: 0);
  int _selectedViewIndex = 0;

  @override
  void dispose() {
    _pageCtrlr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageCtrlr.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
    super.initState();
  }

  void onPageChanged(int selPageId) =>
      setState(() => _selectedViewIndex = selPageId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cash Calculator',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
            onSelected: (String choosenOption) {
              switch (choosenOption) {
                case 'Settings':
                  Navigator.of(context).push(
                    MaterialPageRoute<BuildContext>(
                      builder: (context) => BlocProvider(
                          bloc: CurrencyBloc(), child: SettingsPageView()),
                    ),
                  );
                  break;
                default:
                  throw Exception('No specific option to navigate');
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Settings'].map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option, style: Theme.of(context).textTheme.body1),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        decoration: appGradient,
        child: PageView(
          controller: _pageCtrlr,
          onPageChanged: (int currentSelectedPageIndex) =>
              onPageChanged(currentSelectedPageIndex),
          children: _children,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            title: Text(AppTexts.of(context).calculationText),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text(AppTexts.of(context).currencies),
          ),
        ],
        onTap: (int currentSelectedPageIndex) {
          _pageCtrlr.animateToPage(currentSelectedPageIndex,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(seconds: 1));
          onPageChanged(currentSelectedPageIndex);
        },
      ),
    );
  }
}
