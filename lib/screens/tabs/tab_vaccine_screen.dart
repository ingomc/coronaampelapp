import 'package:coronampel/controller/get_vaccine_controller.dart';
import 'package:coronampel/controller/reload_controller.dart';
import 'package:coronampel/widgets/fund_section.dart';
import 'package:coronampel/widgets/offline_page.dart';
import 'package:coronampel/widgets/loading_list_overlay.dart';
import 'package:coronampel/widgets/update_line.dart';
import 'package:coronampel/widgets/vaccine_state_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matomo/matomo.dart';

class TabVaccineScreen extends TraceableStatelessWidget {
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
              controller: getVaccineController.scrollController,
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
                          right: getVaccineController.lastUpdate.value ==
                                      null ||
                                  getVaccineController.lastUpdate.value == ''
                              ? ''
                              : 'Stand: ${getVaccineController.lastUpdate.value}',
                        ),
                      ),
                    ),
                    GetX<GetVaccineController>(builder: (controller) {
                      if (getVaccineController.germany.value.cumsum7DaysAgo ==
                          null) {
                        return OfflinePage();
                      }
                      return VaccineStateCard(
                        state: 'Deutschland',
                        flag: 'assets/countries/de.png',
                        progress: double.parse((getVaccineController
                                    .germany.value.sumVaccineDoses /
                                (getVaccineController.germany.value.total *
                                    2 *
                                    0.7) *
                                100)
                            .toStringAsFixed(2)),
                        vaccinated:
                            getVaccineController.germany.value.sumVaccineDoses,
                        today: getVaccineController
                            .germany.value.differenceToThePreviousDay,
                        target:
                            (getVaccineController.germany.value.total * 2 * 0.7)
                                .toInt(),
                        label: true,
                      );
                    }),

                    //Timer
                    GetX<GetVaccineController>(
                      builder: (controller) {
                        if (controller.germany.value.total == null) {
                          return Container();
                        }
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
                                    'In den letzten 7 Tagen wurden durchschnittlich ${NumberFormat.decimalPattern('de-DE').format(lastWeek ~/ 7)} Impfdosen pro Tag verabreicht. Aus dieser Zahl lässt sich der wahrscheinliche Zeitpunkt einer Herdenimmunität errechnen. Die Annahme ist, dass eine Herdenimmunität dann erreicht ist, wenn mind. 70% der Einwohner*innen mit jeweils 2 Impfdosen gegen das Virus immunisiert wurden. \nHinweis: Zum aktuellen Zeitpunkt ist das reine Theorie!'),
                                textConfirm: 'Ok',
                                onConfirm: () {
                                  Get.back();
                                },
                              );
                            },
                            child: Container(
                              width: 344,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Icon(
                                        MdiIcons.calendarClock,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
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
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        'Impfdaten pro Bundesland',
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Vaccine states real data
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
                                      progress: progress,
                                      vaccinated:
                                          controller.states[index].vaccinated,
                                      today: controller.states[index]
                                          .differenceToThePreviousDay,
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
                    // Vaccine non pro, not unlocked
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Hinweis',
                          content: Text(
                              'Die Daten für die Bundesländer und für Deutschland ergeben sich aus 1. und/oder 2. Impfungen. Die tatsächliche Richtigkeit kann nicht eingeschätzt werden. Die veröffentlichten Zahlen des RKIs werden außerdem nicht umgehend veröffentlicht, sondern mit einer Verzögerung von 2 - 3 Tagen.'),
                          textConfirm: 'Ok',
                          onConfirm: () {
                            Get.back();
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  MdiIcons.informationOutline,
                                  size: 36,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Text('Informationen zu den Impfdaten'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FundSection(),
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
