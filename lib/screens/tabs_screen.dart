import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/controller/tabs_controller.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:coronaampel/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './citys_screen.dart';
import 'settings_screen.dart';

class TabsScreen extends StatelessWidget {
  static const path = '/';
  final TabsController tabsController = Get.put(TabsController());
  final ApitestController apitestController = Get.put(ApitestController());
  final CityListController cityListController = Get.put(CityListController());

  void _select(value) {
    switch (value) {
      case 'Aktualisieren':
        apitestController.fetchUsers(
          cityListController.citys,
        );
        break;
      case 'Entfernen':
        break;
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(initialPage: tabsController.selectedIndex);

    final List<Map<String, Object>> _pages = [
      {
        'page': CitysScreen(),
        'appbar': AppBar(
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Aktualisieren',
                    child: Row(
                      children: [
                        Icon(Icons.sync),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Aktualisieren'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
          title: Text('🚦 Corona-Ampel 🚦'),
        ),
      },
      {
        'page': TestScreen(),
        'appbar': AppBar(
          centerTitle: true,
          title: Text('Testseite'),
        ),
      },
      {
        'page': SettingsScreen(),
        'appbar': AppBar(
          centerTitle: true,
          title: Text('Einstellungen'),
        ),
      }
    ];
    void _onPageChanged(int page) {
      tabsController.selectedIndex = page;
    }

    void _onTap(int index) {
      tabsController.selectedIndex = index;
      _pageController.animateToPage(tabsController.selectedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCirc);
    }

    return Obx(
      () => Scaffold(
        appBar: _pages[tabsController.selectedIndex]['appbar'],
        body: PageView(
          children: _pages.map((e) => e['page'] as Widget).toList(),
          onPageChanged: _onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.blueGrey[300],
          selectedItemColor: Colors.white,
          currentIndex: tabsController.selectedIndex,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarms),
              label: 'Test',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Einstellungen',
            ),
          ],
        ),
      ),
    );
  }
}
