import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:coronampel/controller/pro_controller.dart';
import 'package:coronampel/controller/rewared_controller.dart';
import 'package:coronampel/data/_interfaces.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerAdContainer extends StatefulWidget {
  const BannerAdContainer({
    Key key,
    @required this.unlockadtype,
  }) : super(key: key);
  final UnlockAdType unlockadtype;

  @override
  _BannerAdContainerState createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> {
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());
  final RewardedController rewardedController = Get.put(RewardedController());
  final ProController proController = Get.put(ProController());
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
        switch (widget.unlockadtype) {
          case UnlockAdType.Its:
            proController.freeITS.value = true;
            break;
          case UnlockAdType.Vaccine:
            proController.freeVaccine.value = true;
            break;
        }
      }
      if (event == RewardedVideoAdEvent.loaded) {
        rewardedController.isloaded.value = true;
      }
      if (event == RewardedVideoAdEvent.closed) {
        if (rewardedController.isRewarded.value == false) {
          Get.snackbar('Feature nicht freigeschalten',
              'Du hast Leider keine Belohnung erhalten.');
          rewardedController.isloaded.value = false;
          RewardedVideoAd.instance.load(
            adUnitId: RewardedVideoAd.testAdUnitId,
            targetingInfo: targetingInfo,
          );
        } else {
          print('close rewarded');
          Get.back();
          Get.snackbar('✅ Intensivation freigeschalten',
              'Du kannst jetzt die Intensivstationstatistiken solange sehen bis deine App einmal geschlossen wurde, danach kannst du die Funktion wieder freischalten.');
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
            : ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(rewardedController.isloaded.value
                        ? 'Jetzt mit Werbung entsperren'
                        : 'Lade Werbeanzeige zum entsperren'),
                    rewardedController.isloaded.value
                        ? Container()
                        : SizedBox(
                            width: 8,
                          ),
                    rewardedController.isloaded.value
                        ? Container()
                        : SizedBox(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 2,
                            ),
                            width: 16,
                            height: 16,
                          ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: rewardedController.isloaded.value
                    ? () async {
                        try {
                          await RewardedVideoAd.instance.show();
                          rewardedController.isloaded.value = false;
                        } on PlatformException catch (e) {
                          print(e.message);
                        }
                      }
                    : null),
      ),
    );
  }
}
