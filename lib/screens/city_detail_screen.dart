import 'package:coronaampel/controller/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityDetailScreen extends StatelessWidget {
  static const path = '/city';
  final citysController = Get.put(CitysController());

  @override
  Widget build(BuildContext context) {
    final cityId = ModalRoute.of(context).settings.arguments as String;
    final city = citysController.citys.firstWhere((city) => city.id == cityId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stadt Name'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('${city.district} ${city.name}'),
                    subtitle: Text('Aktuelle Inzidenz: ${city.incidence}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
