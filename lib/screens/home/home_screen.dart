import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/get_states_controller.dart';
import 'package:coronaampel/screens/tabs/tab_browse_screen.dart';
import 'package:coronaampel/screens/tabs/tab_vaccine_screen.dart';
import 'package:flutter/material.dart';
import 'package:coronaampel/controller/ui/ui_tabs_controller.dart';
import 'package:coronaampel/screens/edit/county_edit_screen.dart';
import 'package:coronaampel/screens/tabs/tab_country_screen.dart';
import 'package:coronaampel/screens/tabs/tab_county_screen.dart';
import 'package:coronaampel/screens/tabs/tab_state_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    TabBrowseScreen(),
    TabCountyScreen(),
    TabStateScreen(),
    TabCountryScreen(),
    TabVaccineScreen(),
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
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GetX<UiTabsController>(
            builder: (controller) {
              return PopupMenuButton(
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
                    if (controller.selectedIndex == 1)
                      PopupMenuItem(
                        value: 'Anpassen',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
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
              );
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
          unselectedItemColor: Theme.of(context).hintColor,
          selectedItemColor: Colors.white,
          currentIndex: uiTabsController.selectedIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.homeSearch),
              label: 'Stöbern',
            ),
            BottomNavigationBarItem(
              icon: new Icon(MdiIcons.homeHeart),
              label: 'Landkreise',
            ),
            BottomNavigationBarItem(
              icon: new Icon(MdiIcons.homeGroup),
              label: 'Bundesländer',
            ),
            BottomNavigationBarItem(
              icon: new Icon(MdiIcons.earth),
              label: 'Weltweit',
            ),
            BottomNavigationBarItem(
              icon: new Icon(MdiIcons.needle),
              label: 'Impfungen',
            ),
          ],
        ),
      ),
    );
  }
}
