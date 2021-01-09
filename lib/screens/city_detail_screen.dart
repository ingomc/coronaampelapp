import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityDetailScreen extends StatelessWidget {
  static const path = '/city';
  final apitestController = Get.put(ApitestController());

  @override
  Widget build(BuildContext context) {
    final cityCounty = ModalRoute.of(context).settings.arguments as String;
    final city = apitestController.userList
        .firstWhere((city) => city.attributes.county == cityCounty);

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
                    title:
                        Text('${city.attributes.bez} ${city.attributes.gen}'),
                    subtitle: Text(
                        'Aktuelle Inzidenz: ${city.attributes.cases7Per100K}'),
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
