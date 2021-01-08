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

  final List<Widget> _pages = [
    CitysScreen(),
    TestScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: tabsController.selectedIndex);
    void _onPageChanged(int page) {
      tabsController.selectedIndex = page;
    }

    void _onTap(int index) {
      tabsController.selectedIndex = index;
      _pageController.animateToPage(tabsController.selectedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad);
    }

    return Scaffold(
      body: PageView(
        children: _pages,
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
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
