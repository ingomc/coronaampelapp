import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/items/city_item.dart';
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
        title: Text('${city.attributes.bez} ${city.attributes.gen}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                tag: '${city.attributes.county}',
                child: CityItem(
                    city.attributes.county,
                    city.attributes.gen,
                    city.attributes.bez,
                    double.parse(
                        (city.attributes.cases7Per100K).toStringAsFixed(1)),
                    false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
