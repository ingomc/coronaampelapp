import 'package:coronaampel/widgets/vaccine_state_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    Center(
                      child: Text('💉'),
                    ),
                    VaccineStateCard(
                      state: 'Bundesland!',
                      progress: 30.1,
                      daysLeft: 1337,
                      vaccinated: 1513377,
                      today: 1337,
                      target: (83021123 * 2 * 0.7).toInt(),
                      label: true,
                    ),

                    //Timer
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Hinweis',
                          content: Text(
                              'Diese Berechnung beruht auf der Annahme, dass eine Herdenimmunität dann erreicht ist, wenn mind. 70% der Einwohner*innen mit jeweils 2 Impfdosen gegen das Virus immunisiert wurden. \nHinweis: Zum aktuellen Zeitpunkt ist das reine Theorie!'),
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
                                      text: 'XX Tage',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' bis zur Herdenimmunität in Deutschland ',
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
