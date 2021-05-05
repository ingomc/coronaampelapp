// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class LoadingListOverlay extends StatelessWidget {
  const LoadingListOverlay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black45),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
