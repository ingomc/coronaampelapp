import 'dart:async';
import 'package:coronampel/data/base_data.dart';
import 'package:coronampel/screens/help/help_screen.dart';
import 'package:coronampel/widgets/fund_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matomo/matomo.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@corona-ampel.app',
      queryParameters: {'subject': 'Corona-Ampel: ... '});

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
                    Text('Inzidenz, Impfstatistik, Intensivstation ...'),
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Kontakt',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: InkWell(
                onTap: () {
                  _launchInBrowser(_emailLaunchUri.toString());
                },
                child: ListTile(
                  leading: Icon(MdiIcons.email),
                  title: Text('info@corona-ampel.app'),
                  trailing: Icon(MdiIcons.launch),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: InkWell(
                onTap: () {
                  _launchInBrowser('https://instagram.com/corona_ampel.app');
                },
                child: ListTile(
                  leading: Icon(MdiIcons.instagram),
                  title: Text('@corona_ampel.app'),
                  trailing: Icon(MdiIcons.launch),
                ),
              ),
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
                    applicationVersion: "1.5.0",
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
                  title: Text('Datenschutz / Impressum'),
                  trailing: Icon(MdiIcons.launch),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Unterstütze durch Teilen',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Du kannst auch ohne Spende helfen. Teile diese App einfach in der Familien Whatsapp-Gruppe, in deiner Instagram-Story oder auf anderen Social-Media Kanälen.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Werbefrei durch Spenden',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          FundSection(),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
