import 'package:coronampel/data/ad_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class NativeAdCard extends StatelessWidget {
  final _controller = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    _controller.setNonPersonalizedAds(true);
    return Container(
        height: 330,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20.0),
        child: NativeAdmob(
          adUnitID: new AdData().adUnitID,
          loading: Center(child: CircularProgressIndicator()),
          error: Text("Failed to load the ad"),
          controller: _controller,
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
        ));
  }
}
