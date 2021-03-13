import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:matomo/matomo.dart';
import 'controller/pinned_countys_controller.dart';
import 'screens/home/home_screen.dart';

void main() async {
  // For play billing library 2.0 on Android, it is mandatory to call
  // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
  // as part of initializing the app.
  InAppPurchaseConnection.enablePendingPurchases();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    MatomoTracker().initialize(
      siteId: 1,
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
      title: Platform.isAndroid ? 'Inzidenz-Ampel' : 'Corona-Ampel',
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
