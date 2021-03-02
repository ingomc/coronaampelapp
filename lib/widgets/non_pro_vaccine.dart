import 'package:coronampel/controller/get_vaccine_controller.dart';
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
    final GetVaccineController getVaccineController =
        Get.put(GetVaccineController());
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
        GetX<GetVaccineController>(
          builder: (controller) {
            if (controller.states.length > 0) {
              return Column(
                children: [
                  ...List.generate(
                    controller.states.length,
                    (index) {
                      final allTotal = controller.states[index].total * 2 * 0.7;
                      final progress = double.parse(
                          (controller.states[index].vaccinated / allTotal * 100)
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
      ],
    );
  }
}
