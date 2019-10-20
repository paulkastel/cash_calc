import 'package:cash_calc/blocs/currency_bloc.dart';
import 'package:cash_calc/services/bloc_provider.dart';
import 'package:cash_calc/utils/app_colors.dart';
import 'package:cash_calc/views/currencies_view.dart';
import 'package:cash_calc/views/exchange_view.dart';
import 'package:cash_calc/views/settings_page_view.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final List<Widget> _children = [
    ExchangeMoneyView(),
    CurrenciesView(),
  ];

  final PageController _pageCtrlr = PageController(initialPage: 0);
  int _selectedViewIndex = 0;

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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.olive, AppColors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.7, 1])),
        child: BlocProvider(
          bloc: CurrencyBloc(),
          child: PageView(
            controller: _pageCtrlr,
            onPageChanged: (int currentSelectedPageIndex) =>
                onPageChanged(currentSelectedPageIndex),
            children: _children,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // TODO(paulkastel): depending on the screen it should do different thing
        tooltip: 'Search for currencies',
        onPressed: () {},
        child: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            title: const Text('Exchange'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: const Text('Currencies'),
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
