import 'dart:async';

import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:coronampel/controller/rewared_controller.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerAdContainer extends StatefulWidget {
  @override
  _BannerAdContainerState createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> {
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());
  final RewardedController rewardedController = Get.put(RewardedController());
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'Coburg',
      'corona',
      'covid',
      'bayern',
    ],
    childDirected: false,
  );

  @override
  void initState() {
    super.initState();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        print('rewarded');
        rewardedController.isRewarded.value = true;
      }
      if (event == RewardedVideoAdEvent.loaded) {
        rewardedController.isloaded.value = true;
      }
      if (event == RewardedVideoAdEvent.closed) {
        if (rewardedController.isRewarded.value == false) {
          Get.snackbar('Feature nicht freigeschalten',
              'Du hast Leider keinen Belohnung erhalten.');
          rewardedController.isloaded.value = false;
          RewardedVideoAd.instance.load(
            adUnitId: RewardedVideoAd.testAdUnitId,
            targetingInfo: targetingInfo,
          );
        }
      }
      if (event == RewardedVideoAdEvent.failedToLoad) {
        print('Error FailedToLoad');
        if (!getConnectivityController.isOffline.value)
          RewardedVideoAd.instance.load(
            adUnitId: RewardedVideoAd.testAdUnitId,
            targetingInfo: targetingInfo,
          );
      }
    };
    RewardedVideoAd.instance.load(
      adUnitId: RewardedVideoAd.testAdUnitId,
      targetingInfo: targetingInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => rewardedController.isRewarded.value
            ? Container(
                child: Text('Feature freigeschalten ✅'),
              )
            : rewardedController.isloaded.value
                ? ElevatedButton(
                    child: const Text('SHOW REWARDED VIDEO'),
                    onPressed: () async {
                      try {
                        await RewardedVideoAd.instance.show();
                        rewardedController.isloaded.value = false;
                      } on PlatformException catch (e) {
                        print(e.message);
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
