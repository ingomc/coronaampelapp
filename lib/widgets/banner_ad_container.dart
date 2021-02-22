import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerAdContainer extends StatefulWidget {
  @override
  _BannerAdContainerState createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'Coburg',
      'corona',
      'covid',
      'bayern',
    ],
    childDirected: false,
  );

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        Get.snackbar('Rewarded', 'Jetzt gibts eine Belohnung');
        print('rewarded');
      }
    };
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      _bannerAd
        ..load()
        ..show(
          // Positions the banner ad 60 pixels from the bottom of the screen
          anchorOffset: 60.0,
          // Positions the banner ad 10 pixels from the center of the screen to the right
          horizontalCenterOffset: 10.0,
          // Banner Position
          anchorType: AnchorType.bottom,
        );
    });

    return Container(
      child: ElevatedButton(
        child: const Text('SHOW REWARDED VIDEO'),
        onPressed: () {
          RewardedVideoAd.instance.show();
        },
      ),
    );
  }
}
