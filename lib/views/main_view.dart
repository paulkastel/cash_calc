import 'package:cash_calc/utils/app_routes.dart';
import 'package:cash_calc/views/count_currencies_view.dart';
import 'package:cash_calc/views/currencies_view.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final List<Widget> _children = [
    CountMoneyView(),
    CurrenciesView(),
  ];

  final PageController _pageCtrlr = PageController(initialPage: 0);
  int _selectedViewIndex = 0;

  void onPageChanged(int selPageId) => setState(() {
        _selectedViewIndex = selPageId;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cash Calculator',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 29),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onSelected: (String choosenOption) {
              switch (choosenOption) {
                case 'Settings':
                  Navigator.pushNamed(context, AppRoutes.settingsNav);
                  break;
                default:
                  throw Exception('No specific option to navigate');
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Settings'].map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageCtrlr,
        onPageChanged: (int currentSelectedPageIndex) =>
            onPageChanged(currentSelectedPageIndex),
        children: _children,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search for currencies',
        onPressed: () {},
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            title: const Text('Count'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: const Text('Currencies'),
          ),
        ],
        onTap: (int currentSelectedPageIndex) {
          _pageCtrlr.animateToPage(currentSelectedPageIndex,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 1));
          onPageChanged(currentSelectedPageIndex);
        },
      ),
    );
  }
}
