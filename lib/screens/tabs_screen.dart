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
  PageController _pageController;
  void _select(value) {
    switch (value) {
      case 'Entfernen':
        break;
      case 'Anpassen':
        break;
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: tabsController.selectedIndex);

    final List<Map<String, Object>> _pages = [
      {
        'page': CitysScreen(),
        'actionbar': AppBar(
          centerTitle: true,
          actions: [
            PopupMenuButton(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return {'Anpassen', 'Entfernen'}.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          title: Text('🚦 Corona-Ampel 🚦'),
        ),
      },
      {
        'page': TestScreen(),
        'actionbar': AppBar(
          centerTitle: true,
          title: Text('Testseite'),
        ),
      },
      {
        'page': SettingsScreen(),
        'actionbar': AppBar(
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
        appBar: _pages[tabsController.selectedIndex]['actionbar'],
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
