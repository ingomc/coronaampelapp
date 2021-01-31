import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

class VaccineStateCard extends StatelessWidget {
  const VaccineStateCard({
    Key key,
    @required this.state,
    @required this.progress,
    @required this.daysLeft,
    @required this.vaccinated,
    @required this.today,
    @required this.target,
    this.label = false,
  }) : super(key: key);

  final String state;
  final double progress;
  final int daysLeft;
  final int vaccinated;
  final int today;
  final int target;
  final bool label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: ExactAssetImage('assets/states/10.png'),
            ),
            trailing: Text(
              'Noch ${NumberFormat.decimalPattern('de-DE').format(daysLeft)} \nTage',
              textAlign: TextAlign.right,
            ),
            title: Text(
              '$state',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Impstatus: ${NumberFormat.decimalPattern('de-DE').format(progress)} %'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 10,
              percent: progress / 100,
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Theme.of(context).primaryColor,
              progressColor: Colors.green,
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:
                    Text('70%', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${NumberFormat.compact(locale: 'de-DE').format(vaccinated)} verabreicht \n(+${NumberFormat.decimalPattern('de-DE').format(today)})',
                  ),
                ),
                Text(
                  '${NumberFormat.compact(locale: 'de-DE').format(target)}',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          if (label == true)
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                child: Text(
                  'je 2 Impfdosen für 70% aller \nEinwohner*innen',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
