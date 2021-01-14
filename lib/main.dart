import 'package:coronaampel/controller/theme_controller.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './screens/tabs_screen.dart';
import './screens/city_detail_screen.dart';
import 'controller/apitest_controller.dart';
import 'controller/city_list_controller.dart';
import 'controller/tabs_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themecontroller = Get.put(ThemeController());
    final apitestController = Get.put(ApitestController());
    final cityListController = Get.put(CityListController());
    final tabsController = Get.put(TabsController());

    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          defaultTransition: Transition.cupertino,
          theme: themecontroller.theme,
          title: 'Corona-Ampel',
          debugShowCheckedModeBanner: false,
          //when initial Route is given no need to add home widget for initial start point of app
          //full app route structure
          getPages: [
            GetPage(name: TabsScreen.path, page: () => TabsScreen()),
            GetPage(
                name: CityDetailScreen.path, page: () => CityDetailScreen()),
            GetPage(name: SearchScreen.path, page: () => SearchScreen()),
          ],
        );
      },
    );
  }
}
