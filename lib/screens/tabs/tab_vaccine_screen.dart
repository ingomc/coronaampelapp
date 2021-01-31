import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  ExactAssetImage('assets/states/10.png'),
                            ),
                            trailing: Text(
                              'Noch 1.345 \nTage',
                              textAlign: TextAlign.right,
                            ),
                            title: Text(
                              'Bundesland',
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Impstatus: 3,1%'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: LinearPercentIndicator(
                              lineHeight: 10,
                              percent: 0.011,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: Theme.of(context).primaryColor,
                              progressColor: Colors.green,
                              trailing: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text('70%',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '1.543.456 verabreicht',
                                  ),
                                ),
                                Text(
                                  '116,4 Mio',
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
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
                    ),

                    //Timer
                    GestureDetector(
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
