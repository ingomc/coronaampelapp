import 'package:coronaampel/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './screens/tabs_screen.dart';
import './screens/city_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themecontroller = Get.put(ThemeController());
    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          theme: themecontroller.theme,
          title: 'Corona-Ampel',
          debugShowCheckedModeBanner: false,
          // starting point from where app should begin
          initialRoute: '/',
          //when initial Route is given no need to add home widget for initial start point of app
          //full app route structure
          routes: {
            TabsScreen.path: (context) => TabsScreen(),
            CityScreen.path: (context) => CityScreen(),
          },
        );
      },
    );
  }
}
