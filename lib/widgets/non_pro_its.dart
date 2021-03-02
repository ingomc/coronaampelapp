import 'dart:ui';

import 'package:coronampel/data/_interfaces.dart';
import 'package:coronampel/screens/ad/ad_screen.dart';
import 'package:coronampel/screens/detail/county_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NonProITS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.lock,
                size: 16,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Intensivstation',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Stack(
          children: [
            Column(
              children: [
                CityDetailsRowCard(
                  label: 'Betten frei',
                  percentage: '0',
                  number: '0',
                ),
                CityDetailsRowCard(
                  label: 'Betten belegt',
                  number: '0',
                ),
                CityDetailsRowCard(
                  label: 'Betten belegt mit Covid-19',
                  percentage: '0',
                  number: '0',
                ),
                CityDetailsRowCard(
                  label: 'Covid-19-Fälle die beatmet werden',
                  number: '0',
                ),
              ],
            ),
            Positioned.fill(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              color: Colors.black.withOpacity(0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Intensivstation kostenlos entsperren:',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(AdScreen(
                                  unlockadtype: UnlockAdType.Its,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    MdiIcons.lockOpenVariantOutline,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Funktion jetzt kostenlos entsperren'),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
