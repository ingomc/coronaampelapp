import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FundSection extends StatelessWidget {
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
    return Container(
      width: 480,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Diese App soll immer Werbefrei und ohne Datenverkauf an Dritte bleiben. Mit einer kleinen Spende hilfst du dabei, dass es so bleibt.',
                // textAlign: TextAlign.center,
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
                  leading: Icon(
                    MdiIcons.heart,
                    color: Colors.red,
                  ),
                  title: Text(
                      'Spende und helfe mir diese App weiter zu verbessern'),
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
