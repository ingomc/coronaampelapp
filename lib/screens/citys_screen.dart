import 'dart:ffi';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  final cityListController = Get.put(CityListController());
  final ApitestController apitestController = Get.put(ApitestController());

  void _select(value) {
    switch (value) {
      case 'Entfernen':
        break;
      case 'Anpassen':
        break;
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return {'Anpassen', 'Entfernen'}.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text('🚦 Corona-Ampel 🚦'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<CityListController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.citys.length,
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 100),
                  itemBuilder: (context, index) {
                    double incidence = -1.0;
                    if (apitestController.userList != null &&
                        apitestController.userList.length > 0) {
                      Feature asyncIncidence = apitestController.userList
                          .firstWhere(
                              (cityItem) =>
                                  cityItem.attributes.county ==
                                  controller.citys[index].county,
                              orElse: () => null);

                      if (asyncIncidence != null) {
                        incidence = double.parse(
                            (asyncIncidence.attributes.cases7Per100K)
                                .toStringAsFixed(1));
                      }
                    }

                    return CityItem(
                      controller.citys[index].county,
                      controller.citys[index].name,
                      controller.citys[index].district,
                      incidence,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
