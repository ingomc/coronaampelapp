import 'package:coronaampel/controller/tabs_controller.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:coronaampel/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './citys_screen.dart';
import 'settings_screen.dart';

class TabsScreen extends StatelessWidget {
  static const path = '/';

  final List<Map<String, Object>> _pages = [
    {
      'page': CitysScreen(),
    },
    {
      'page': TestScreen(),
    },
    {
      'page': SettingsScreen(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    final TabsController tabsController = Get.put(TabsController());

    return Scaffold(
      body: Obx(() => _pages[tabsController.selectedIndex]['page']),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.blueGrey[300],
          selectedItemColor: Colors.white,
          currentIndex: tabsController.selectedIndex,
          onTap: (index) => tabsController.selectedIndex = index,
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
