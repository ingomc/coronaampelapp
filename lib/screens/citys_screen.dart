import 'dart:math';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  final CityListController cityListController = Get.put(CityListController());
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

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    await apitestController.fetchUsers(
      cityListController.citys,
    );
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
              child: RefreshIndicator(
                child: Obx(
                  () => ListView.builder(
                    itemCount: apitestController.userList.length,
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 100),
                    itemBuilder: (context, index) {
                      return CityItem(
                        apitestController.userList[index].attributes.county,
                        apitestController.userList[index].attributes.gen,
                        apitestController.userList[index].attributes.bez,
                        double.parse((apitestController
                                    .userList[index].attributes.cases7Per100K)
                                .toStringAsFixed(1)) +
                            (new Random()).nextInt(100),
                      );
                    },
                  ),
                ),
                onRefresh: _loadData,
              ),
            ),
            RaisedButton(
              onPressed: () {
                apitestController.fetchUsers(
                  cityListController.citys,
                );
              },
              child: Text('refresh'),
            )
          ],
        ),
      ),
    );
  }
}
