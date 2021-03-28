import 'package:coronampel/widgets/incidence_number_container.dart';
import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';

class HelpScreen extends TraceableStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hilfe & Quellen'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Legende',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Inzidenz: 0 - 35'),
                    trailing: IncidenceNumberContainer(34.9),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Inzidenz: 35 - 50'),
                    trailing: IncidenceNumberContainer(49.9),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Inzidenz: 50 - 100'),
                    trailing: IncidenceNumberContainer(99.9),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Inzidenz: > 100'),
                    trailing: IncidenceNumberContainer(133.7),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Quellen',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Quelle RKI: Alle Zahlen zu Deutschland und deren Landkreise kommen direkt vom Robert-Koch-Institut.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Quelle Worldometer: Fälle Weltweit. (https://www.worldometers.info/coronavirus/)',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hinweis: Bitte gehen Sie davon aus, wenn Daten komisch aussehen, dass sie auch falsch sein könnten. Weder ich noch meine Quellen garantieren 100% korrekte Zahlen! Das RKI und die anderen Quellen sind bei weitem nicht fehlerfrei. Beinahe täglich kommt es zu Probleme bei Daten aus einzelnen Landkreisen. Ob falsche oder fehlende Werte dann zu einem späteren Zeitpunkt korrigiert werden ist leider nicht bekannt.',
            ),
          ),
        ],
      ),
    );
  }
}
