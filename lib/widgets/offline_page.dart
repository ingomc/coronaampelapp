import 'package:coronampel/controller/reload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OfflinePage extends StatelessWidget {
  final ReloadController reloadController = Get.put(ReloadController());
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .5,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Icon(
                      MdiIcons.wifiOff,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Text('Keine Daten vorhanden',
                  style: Theme.of(context).textTheme.headline5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Du bist wahrscheinlich nicht mit dem Internet verbunden.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  await reloadController.reload();
                },
                child: Text('Jetzt aktualisieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
