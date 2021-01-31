import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                            title: Text(
                              'Bundesland',
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Impstatus: 3,1%'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: LinearPercentIndicator(
                              lineHeight: 20,
                              percent: 0.011,
                              backgroundColor: Theme.of(context).primaryColor,
                              progressColor: Colors.green,
                              trailing: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('70%',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
