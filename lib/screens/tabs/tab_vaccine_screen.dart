import 'package:coronaampel/widgets/update_line.dart';
import 'package:coronaampel/widgets/vaccine_state_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabVaccineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () {},
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
                    UpdateLine(
                      left: ' XX:XX Uhr',
                      right: 'Stand: XX:XX ',
                    ),
                    VaccineStateCard(
                      state: 'Deutschland',
                      flag: 'assets/countries/de.png',
                      progress: 30.1,
                      daysLeft: 1337,
                      vaccinated: 1513377,
                      today: 1337,
                      target: (83021123 * 2 * 0.7).toInt(),
                      label: true,
                    ),

                    //Timer
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Hinweis',
                            content: Text(
                                'In den letzten 7 Tagen wurden durchschnittlich XX Impfdosen verabreicht. Aus dieser Zahl berechne ich den wahrscheinlichen Zeitpunkt an dem die Herdenimmunität erreicht ist. Die Annahme ist, dass eine Herdenimmunität dann erreicht ist, wenn mind. 70% der Einwohner*innen mit jeweils 2 Impfdosen gegen das Virus immunisiert wurden. \nHinweis: Zum aktuellen Zeitpunkt ist das reine Theorie!'),
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
                                            '${NumberFormat.decimalPattern('de-DE').format(1245)} Tage',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            ' (14.04.2024) bis zur Herdenimmunität in Deutschland ',
                                      ),
                                      WidgetSpan(
                                        baseline: TextBaseline.alphabetic,
                                        alignment: PlaceholderAlignment.middle,
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
        ],
      ),
    ));
  }
}
