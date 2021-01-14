import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/controller/tabs_controller.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:coronaampel/screens/states_screen.dart';
import 'package:coronaampel/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './citys_screen.dart';
import 'settings_screen.dart';

class TabsScreen extends StatelessWidget {
  static const path = '/';
  final TabsController tabsController = Get.find<TabsController>();
  final ApitestController apitestController = Get.find<ApitestController>();
  final CityListController cityListController = Get.find<CityListController>();

  void _select(value) {
    switch (value) {
      case 'Aktualisieren':
        apitestController.fetchUsers(
          cityListController.citys,
        );
        break;
      case 'Einstellungen':
        Get.to(SettingsScreen());
        break;
    }
    // print(value);
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(initialPage: tabsController.selectedIndex);

    final List<Map<String, Object>> _pages = [
      {
        'page': CitysScreen(),
      },
      {
        'page': TestScreen(),
      },
      {
        'page': StatesScreen(),
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
        appBar: AppBar(
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
                  PopupMenuItem(
                    value: 'Anpassen',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Anpassen'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Einstellungen',
                    child: Row(
                      children: [
                        Icon(Icons.tune_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Einstellungen'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
          title: Text('🚦 Corona-Ampel 🚦'),
        ),
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
              label: 'Landkreise',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Bundesländer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Global',
            ),
          ],
        ),
      ),
    );
  }
}
