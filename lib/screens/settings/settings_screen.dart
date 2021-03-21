import 'dart:async';
import 'dart:io';
import 'package:coronampel/data/base_data.dart';
import 'package:coronampel/screens/devtools_screen.dart';
import 'package:coronampel/screens/help/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matomo/matomo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';

class SettingsScreen extends TraceableStatelessWidget {
  final _webUrl = 'https://corona-ampel.app/datenschutz';
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
        title: Text('Info & Hilfe'),
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
                      '🚦 ${BaseData.appName} 🚦',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Inzidenz, Intensivstation und mehr'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: InkWell(
                onTap: () {
                  _launchInBrowser('https://paypal.me/ingomc?locale.x=de_DE');
                },
                child: ListTile(
                  leading: Icon(MdiIcons.heart),
                  title: Text(
                      'Spende und helfe mir diese App weiter zu verbessern'),
                  trailing: Icon(MdiIcons.launch),
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
                          'Kennst du schon die Inzidenz-Ampel App? Dort kann man die aktuellen Inzidenzen, Intensivstationbelegung und vieles mehr anschauen. http://corona-ampel.app \n \n LG',
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
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () async {
                        await Get.defaultDialog(
                            title: 'Kontakt',
                            textConfirm: 'OK',
                            onConfirm: () {
                              Get.back();
                            },
                            middleText:
                                'Wenn du mit mir Kontakt aufnehmen willst, melde dich unter: \n \n info@corona-ampel.app');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.email),
                            ),
                            Text('Kontakt'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onDoubleTap: () {
                Get.to(Devtools());
              },
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: Colors.transparent),
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hilfe',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: InkWell(
                onTap: () {
                  Get.to(HelpScreen());
                },
                child: ListTile(
                  leading: Icon(MdiIcons.helpCircle),
                  title: Text('Hilfe & Quellen'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Rechtliches',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: InkWell(
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                    applicationName: BaseData.appName,
                    applicationVersion: "1.4.2",
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
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
          SizedBox(
            height: 32,
          ),
          if (Platform.isAndroid)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Google- und Playstore-Richtlinien verbieten es diese App so zu benennen wie es ursprünglich geplant war, weshalb sie nun ${BaseData.appName} heisst.',
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Diese App dient einer reinen übersichtlichen Darstellung der wichtigsten Daten zur aktuellen Lage. Da Regierungsentscheidungen auf aktuellen Inzidenzwerten basieren, ist der Fokus der App der 7 Tage Inzidenz Wert pro 100.000EW.',
            ),
          ),
        ],
      ),
    );
  }
}
