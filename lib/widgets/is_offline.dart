import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsOffline extends StatefulWidget {
  @override
  _IsOfflineState createState() => _IsOfflineState();
}

class _IsOfflineState extends State<IsOffline> {
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());
  StreamSubscription subscription;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        getConnectivityController.isOffline.value = false;
      } else {
        getConnectivityController.isOffline.value = true;
      }
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          width: double.infinity,
          height: getConnectivityController.isOffline.value ? 46 : 0,
          decoration: BoxDecoration(color: Colors.red),
          child: Container(
            height: 46,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Offline'),
                    ElevatedButton(
                      onPressed: () async {
                        ConnectivityResult connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          getConnectivityController.isOffline.value = false;
                          Get.snackbar('Du bist wieder ONLINE 👍🏻',
                              'Neue Daten werden geladen ...');
                        } else {
                          getConnectivityController.isOffline.value = true;
                          Get.snackbar('Keine Verbindung zum Internet',
                              'Bitte überprüfe ob du online bist oder probiere es zu einem späteren Zeitpunkt noch einmal.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[600],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sync,
                              size: 16,
                            ),
                            Text('Aktualisieren'),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
