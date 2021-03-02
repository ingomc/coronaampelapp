import 'dart:ui';

import 'package:coronampel/controller/get_vaccine_controller.dart';
import 'package:coronampel/data/_interfaces.dart';
import 'package:coronampel/screens/ad/ad_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'vaccine_state_card.dart';

class NonProVaccine extends StatelessWidget {
  const NonProVaccine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.lock,
                size: 16,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Impfdaten pro Bundesland',
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
            GetX<GetVaccineController>(
              builder: (controller) {
                if (controller.states.length > 0) {
                  return Column(
                    children: [
                      ...List.generate(
                        controller.states.length,
                        (index) {
                          final allTotal =
                              controller.states[index].total * 2 * 0.7;
                          // ignore: unused_local_variable
                          final progress = double.parse(
                              (controller.states[index].vaccinated /
                                      allTotal *
                                      100)
                                  .toStringAsFixed(2));
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                            ),
                            child: VaccineStateCard(
                              state: controller.states[index].name,
                              flag:
                                  'assets/states/${controller.states[index].rs}.png',
                              progress: 0,
                              vaccinated: 0,
                              today: 0,
                              target: allTotal.toInt(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
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
                  Column(
                    children: [
                      SizedBox(height: 32),
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
                                    'Impfdaten kostenlos entsperren:',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.bottomSheet(AdScreen(
                                      unlockadtype: UnlockAdType.Vaccine,
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
                                      Text(
                                          'Funktion jetzt kostenlos entsperren'),
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
