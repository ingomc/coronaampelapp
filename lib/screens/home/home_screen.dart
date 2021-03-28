import 'package:coronampel/controller/get_browse_controller.dart';
import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/get_states_controller.dart';
import 'package:coronampel/controller/get_vaccine_controller.dart';
import 'package:coronampel/controller/reload_controller.dart';
import 'package:coronampel/screens/settings/settings_screen.dart';
import 'package:coronampel/screens/tabs/tab_browse_screen.dart';
import 'package:coronampel/screens/tabs/tab_vaccine_screen.dart';
import 'package:coronampel/widgets/keep_alive_page.dart';
import 'package:flutter/material.dart';
import 'package:coronampel/controller/ui/ui_tabs_controller.dart';
import 'package:coronampel/screens/edit/county_edit_screen.dart';
import 'package:coronampel/screens/tabs/tab_country_screen.dart';
import 'package:coronampel/screens/tabs/tab_county_screen.dart';
import 'package:coronampel/screens/tabs/tab_state_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  final UiTabsController uiTabsController = Get.put(UiTabsController());
  final GetVaccineController getVaccineController =
      Get.put(GetVaccineController());
  final GetBrowseController getBrowseController =
      Get.put(GetBrowseController());
  final GetStatesController getStatesController =
      Get.put(GetStatesController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final ReloadController reloadController = Get.put(ReloadController());
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());

  void _select(value) async {
    switch (value) {
      case 'Aktualisieren':
        await reloadController.reload();
        break;
      case 'Anpassen':
        Get.to(CountyEditScreen());
        break;
      case 'Info':
        Get.to(SettingsScreen());
        break;
    }
    // print(value);
  }

  final List<Widget> _pages = [
    KeepAlivePage(child: TabBrowseScreen()),
    KeepAlivePage(child: TabCountyScreen()),
    KeepAlivePage(child: TabStateScreen()),
    KeepAlivePage(child: TabCountryScreen()),
    KeepAlivePage(child: TabVaccineScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    // Tabs
    void _onPageChanged(int page) {
      uiTabsController.saveSelectedIndex = page;
    }

    final PageController _pageController = PageController(
        initialPage: uiTabsController.selectedIndex.value, keepPage: true);

    void _onTap(int index) {
      // if tab is already select, then scrollpage to top
      if (uiTabsController.selectedIndex.value == index) {
        switch (index) {
          // Stoebern
          case 0:
            getBrowseController.scrollController.animateTo(
              0.0,
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 1000),
            );
            break;
          // Landkreise
          case 1:
            getCountysController.scrollController.animateTo(
              0.0,
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 1000),
            );
            break;
          // Bundlaender
          case 2:
            getStatesController.scrollController.animateTo(
              0.0,
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 1000),
            );
            break;
          // Impfungen
          case 4:
            getVaccineController.scrollController.animateTo(
              0.0,
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 1000),
            );
            break;
        }
      } else {
        // go to Page
        uiTabsController.saveSelectedIndex = index;
        _pageController.animateToPage(uiTabsController.selectedIndex.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(MdiIcons.dotsVertical),
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
                if (uiTabsController.selectedIndex.value == 1)
                  PopupMenuItem(
                    key: Key(uiTabsController.selectedIndex.value.toString()),
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
                  value: 'Info',
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Info & Hilfe'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        title: Image.asset(
          'assets/site-logo.png',
          fit: BoxFit.contain,
          height: 32,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: _pages,
              onPageChanged: _onPageChanged,
              controller: _pageController,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).hintColor,
          selectedItemColor: Colors.white,
          currentIndex: uiTabsController.selectedIndex.value,
          onTap: _onTap,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.homeSearch),
              label: 'Stöbern',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.homeHeart),
              label: 'Landkreise',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.homeGroup),
              label: 'Bundesländer',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.earth),
              label: 'Weltweit',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: new Icon(MdiIcons.needle),
              label: 'Impfungen',
            ),
          ],
        ),
      ),
    );
  }
}
