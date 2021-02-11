import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';

class SettingsScreen extends StatelessWidget {
  final _webUrl = 'https://corona-ampel.app';
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print(await canLaunch(url));
      throw 'Could not launch $url';
    }
  }

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
                      '🚦 CoronAMPEL 🚦',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                      onTap: () => LaunchReview.launch(),
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
                      onTap: () {
                        Share.share(
                          'Kennst du schon die Corona-Ampel App? Dort kann man die aktuellen Inzidenzen, Impfstatus, Intensivstationbelegung und vieles mehr anschauen. http://corona-ampel.app \n \n LG',
                          subject: "Empfehlung: Coole Corona-Übersicht",
                        );
                      },
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
              child: InkWell(
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              spreadRadius: -5,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            'assets/launcher/playstore-icon.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    applicationName: "CoronAMPEL",
                    applicationVersion: "1.0.0",
                  );
                },
                child: ListTile(
                  leading: Icon(MdiIcons.clipboardText),
                  title: Text('Lizenzen'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Card(
              child: InkWell(
                onTap: () {
                  _launchInBrowser(_webUrl);
                },
                child: ListTile(
                  leading: Icon(MdiIcons.shieldLock),
                  title: Text('Datenschutz'),
                  trailing: Icon(MdiIcons.launch),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
