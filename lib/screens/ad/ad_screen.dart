import 'package:coronampel/data/_interfaces.dart';
import 'package:coronampel/widgets/banner_ad_container.dart';
import 'package:flutter/material.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({
    Key key,
    @required this.unlockadtype,
  }) : super(key: key);
  final UnlockAdType unlockadtype;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(unlockadtype == UnlockAdType.Its
            ? 'Intensivstation freischalten'
            : 'Impfdaten freischalten'),
      ),
      body: Center(
        child: Container(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  unlockadtype == UnlockAdType.Its
                      ? 'Intensivstation kostenlos freischalten:'
                      : 'Impfdaten kostenlos freischalten:',
                  textAlign: TextAlign.center,
                ),
              ),
              BannerAdContainer(
                unlockadtype: unlockadtype,
              ),
              SizedBox(height: 16),
              Text(
                'oder',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Mit der PRO-Mitgliedschaft (einm. 2,49€) alle Funktionen für immer freischalten und Werbung entfernen:',
                ),
              ),
              Row(
                children: [
                  Text('∙'),
                  SizedBox(
                    width: 4,
                  ),
                  RichText(
                    text: TextSpan(text: 'Unterstütze mich ❤️'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('∙'),
                  SizedBox(
                    width: 4,
                  ),
                  RichText(
                    text: TextSpan(text: 'Nie mehr Werbung'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('∙'),
                  SizedBox(
                    width: 4,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Alle Funktionen für immer freigeschalten'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Jetzt mit PRO alles freischalten'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
