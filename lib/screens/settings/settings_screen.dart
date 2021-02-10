import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'CoronAMPEL',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Inzidenz, Intensivstation, Impfungen'),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Design und Entwicklung von André Bellmann aus Coburg, Deutschland.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.thumb_up_rounded),
                            ),
                            Text('Bewerten'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.share),
                            ),
                            Text('Teilen'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Rechtliches',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Datenschutz'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Lizenzen'),
              ),
            ),
          ),
        ],

        // Container(
        //   child: Center(
        //     child: FlatButton(
        //       onPressed: () {
        //         showLicensePage(
        //           context: context,
        //           applicationIcon: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(20),
        //               clipBehavior: Clip.hardEdge,
        //               child: Image.asset(
        //                 'assets/launcher/playstore-icon.png',
        //                 height: 100,
        //                 width: 100,
        //               ),
        //             ),
        //           ),
        //           applicationName: "CoronAMPEL",
        //           applicationVersion: "1.0.0",
        //           // Other parameters
        //         );
        //       },
        //       child: Text('Show Licenses'),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
