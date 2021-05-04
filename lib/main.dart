// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/pinned_countys_controller.dart';
import 'screens/home/home_screen.dart';
import 'package:matomo/matomo.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    MatomoTracker().initialize(
      siteId: kIsWeb ? 2 : 1,
      url: 'https://apptracking.andre-bellmann.de/matomo.php',
    );
  }
  final PinnedCountysController pinnedCountysController =
      Get.put(PinnedCountysController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: false,
      title: 'Corona-Ampel',
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        brightness: Brightness.dark,
        accentColor: Colors.blueGrey,
      ),
      home: Scaffold(
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
