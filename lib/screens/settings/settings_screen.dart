import 'dart:async';
import 'dart:io';
import 'package:coronampel/data/base_data.dart';
import 'package:coronampel/screens/help/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
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
                      '${BaseData.appName}',
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
                  _launchInBrowser(
                      'https://ko-fi.com/coronaampel/?hidefeed=true&widget=true&embed=true');
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
                              child: Icon(MdiIcons.email),
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
                  trailing: Icon(MdiIcons.chevronRight),
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
                    applicationVersion: "1.4.12",
                  );
                },
                child: ListTile(
                  leading: Icon(MdiIcons.clipboardText),
                  title: Text('Lizenzen'),
                  trailing: Icon(MdiIcons.chevronRight),
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
        ],
      ),
    );
  }
}
