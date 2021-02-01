import 'package:coronaampel/controller/get_vaccine_controller.dart';
import 'package:coronaampel/controller/reload_controller.dart';
import 'package:coronaampel/widgets/loading_list_overlay.dart';
import 'package:coronaampel/widgets/update_line.dart';
import 'package:coronaampel/widgets/vaccine_state_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabVaccineScreen extends StatelessWidget {
  final GetVaccineController getVaccineController =
      Get.put(GetVaccineController());
  final ReloadController reloadController = Get.put(ReloadController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getVaccineController.isRefreshIndicatorActive.value = true;
    await reloadController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _loadData,
      backgroundColor: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          CupertinoScrollbar(
            child: ListView.builder(
              itemCount: 1,
              padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Obx(
                        () => UpdateLine(
                          left: ' ${getVaccineController.dateUpdated} Uhr',
                          right:
                              'Stand: ${getVaccineController.lastUpdate == null ? "" : getVaccineController.lastUpdate}',
                        ),
                      ),
                    ),
                    Obx(
                      () => VaccineStateCard(
                        state: 'Deutschland',
                        flag: 'assets/countries/de.png',
                        progress:
                            getVaccineController.germany.value.sumVaccineDoses /
                                (getVaccineController.germany.value.total *
                                    2 *
                                    0.7) *
                                100,
                        vaccinated:
                            getVaccineController.germany.value.sumVaccineDoses,
                        today: getVaccineController
                            .germany.value.differenceToThePreviousDay,
                        target:
                            (getVaccineController.germany.value.total * 2 * 0.7)
                                .toInt(),
                        label: true,
                      ),
                    ),

                    //Timer
                    GetX<GetVaccineController>(
                      builder: (controller) {
                        final left = controller.germany.value.total * 0.7 * 2 -
                            controller.germany.value.sumVaccineDoses;
                        final lastWeek =
                            controller.germany.value.sumVaccineDoses -
                                controller.germany.value.cumsum7DaysAgo;
                        final perDay = lastWeek / 7;
                        final daysleft = left ~/ perDay;
                        final today = new DateTime.now();
                        final targetDate =
                            today.add(new Duration(days: daysleft));
                        final formatedTargetDate =
                            new DateFormat("dd.MM.yyyy").format(targetDate);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Hinweis',
                                content: Text(
                                    'In den letzten 7 Tagen wurden durchschnittlich ${NumberFormat.decimalPattern('de-DE').format(lastWeek ~/ 7)} Impfdosen pro Tag verabreicht. Aus dieser Zahl berechne ich den wahrscheinlichen Zeitpunkt an dem die Herdenimmunität erreicht ist. Die Annahme ist, dass eine Herdenimmunität dann erreicht ist, wenn mind. 70% der Einwohner*innen mit jeweils 2 Impfdosen gegen das Virus immunisiert wurden. \nHinweis: Zum aktuellen Zeitpunkt ist das reine Theorie!'),
                                textConfirm: 'Ok',
                                onConfirm: () {
                                  Get.back();
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Icon(
                                      MdiIcons.calendarClock,
                                      size: 36,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Noch ',
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                '${NumberFormat.decimalPattern('de-DE').format(daysleft)} Tage',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                ' ($formatedTargetDate) bis zur Herdenimmunität in Deutschland ',
                                          ),
                                          WidgetSpan(
                                            baseline: TextBaseline.alphabetic,
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Icon(
                                              Icons.info_outline,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    VaccineStateCard(
                      state: 'Bayern',
                      flag: 'assets/states/09.png',
                      progress: 3.1,
                      vaccinated: 1513377,
                      today: 1337,
                      target: (83021123 * 2 * 0.7).toInt(),
                    ),

                    VaccineStateCard(
                      state: 'Bundesland!',
                      flag: 'assets/states/11.png',
                      progress: 69,
                      vaccinated: 1513377,
                      today: 1337,
                      target: (83021123 * 2 * 0.7).toInt(),
                    ),
                  ],
                );
              },
            ),
          ),
          GetX<GetVaccineController>(
            builder: (controller) {
              if (controller.isLoading.value &&
                  !controller.isRefreshIndicatorActive.value) {
                return LoadingListOverlay();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    ));
  }
}
