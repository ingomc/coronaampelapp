import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/get_states_controller.dart';
import 'package:flutter/material.dart';
import 'package:coronaampel/controller/ui/ui_tabs_controller.dart';
import 'package:coronaampel/screens/edit/county_edit_screen.dart';
import 'package:coronaampel/screens/tabs/tab_country_screen.dart';
import 'package:coronaampel/screens/tabs/tab_county_screen.dart';
import 'package:coronaampel/screens/tabs/tab_state_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final UiTabsController uiTabsController = Get.put(UiTabsController());
  final GetStatesController getStatesController =
      Get.put(GetStatesController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());

  void _select(value) {
    switch (value) {
      case 'Aktualisieren':
        getStatesController.fetchStates();
        getCountysController.fetchCountys();
        break;
      case 'Anpassen':
        Get.to(CountyEditScreen());
        break;
      case 'Einstellungen':
        // Get.to(SettingsScreen());
        break;
    }
    // print(value);
  }

  final List<Widget> _pages = [
    TabCountyScreen(),
    TabStateScreen(),
    TabCountryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Tabs
    void _onPageChanged(int page) {
      uiTabsController.saveSelectedIndex = page;
    }

    final PageController _pageController =
        PageController(initialPage: uiTabsController.selectedIndex);

    void _onTap(int index) {
      uiTabsController.saveSelectedIndex = index;
      _pageController.animateToPage(uiTabsController.selectedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCirc);
    }

    return Scaffold(
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
                      Icon(
                        Icons.sync,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
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
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
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
                      Icon(
                        Icons.tune_outlined,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
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
        children: _pages,
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).hintColor,
          selectedItemColor: Colors.white,
          currentIndex: uiTabsController.selectedIndex,
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
