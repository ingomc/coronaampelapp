import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityDetailScreen extends StatelessWidget {
  static const path = '/city';
  final cityListController = Get.put(CityListController());

  @override
  Widget build(BuildContext context) {
    final cityId = ModalRoute.of(context).settings.arguments as String;
    final city =
        cityListController.citys.firstWhere((city) => city.id == cityId);

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
