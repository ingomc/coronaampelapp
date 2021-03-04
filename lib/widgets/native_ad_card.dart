import 'dart:async';

import 'package:coronampel/data/ad_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class NativeAdCard extends StatefulWidget {
  @override
  _NativeAdCardState createState() => _NativeAdCardState();
}

class _NativeAdCardState extends State<NativeAdCard> {
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 330;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _nativeAdController.setNonPersonalizedAds(true);
    return Container(
      height: _height,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 20.0),
          child: NativeAdmob(
            adUnitID: new AdData().adUnitID,
            numberAds: 2,
            loading: Container(),
            error: Text("Failed to load the ad"),
            controller: _nativeAdController,
            type: NativeAdmobType.full,
            options: NativeAdmobOptions(
              advertiserTextStyle: NativeTextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color),
              callToActionStyle: NativeTextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color),
              headlineTextStyle: NativeTextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color),
              bodyTextStyle: NativeTextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color),
              adLabelTextStyle: NativeTextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
          ),
        ),
      ),
    );
  }
}
