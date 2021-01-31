import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VaccineStateCard extends StatelessWidget {
  const VaccineStateCard({
    Key key,
    @required this.state,
    @required this.flag,
    @required this.progress,
    this.daysLeft = 0,
    @required this.vaccinated,
    @required this.today,
    @required this.target,
    this.label = false,
  }) : super(key: key);

  final String state;
  final String flag;
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
              backgroundImage: ExactAssetImage('$flag'),
            ),
            trailing: DaysLeft(daysLeft: daysLeft),
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
              percent: progress / 70,
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
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  'je 2 Impfdosen für 70% aller \nEinwohner*innen',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          if (label == true)
            SizedBox(
              height: 16,
            ),
        ],
      ),
    );
  }
}

class DaysLeft extends StatelessWidget {
  const DaysLeft({
    Key key,
    this.daysLeft,
  }) : super(key: key);

  final int daysLeft;

  @override
  Widget build(BuildContext context) {
    if (daysLeft > 0)
      return Text(
        'Noch ${NumberFormat.decimalPattern('de-DE').format(1234)} \nTage',
        textAlign: TextAlign.right,
      );
    else
      return Text('');
  }
}
