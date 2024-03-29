// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VaccineStateCard extends StatelessWidget {
  const VaccineStateCard({
    Key key,
    @required this.state,
    @required this.flag,
    @required this.progress,
    @required this.vaccinated,
    @required this.today,
    @required this.target,
    this.label = false,
  }) : super(key: key);

  final String state;
  final String flag;
  final double progress;
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
            title: Text(
              '$state',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Impfstatus: ${NumberFormat.decimalPattern('de-DE').format(progress)} %'),
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
                    Text('100%', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${vaccinated < 1000000 ? NumberFormat.decimalPattern('de-DE').format(vaccinated) : NumberFormat.compact(locale: 'de-DE').format(vaccinated)}',
                  ),
                ),
                Text(
                  'ca. ${NumberFormat.compact(locale: 'de-DE').format(target)}',
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
                  'Mind. Grundimmunisierte Personen (egal ob mit oder ohne Booster)',
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
