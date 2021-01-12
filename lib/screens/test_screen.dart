import 'dart:ffi';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  final ApitestController apitestController = Get.put(ApitestController());
  final CityListController cityListController = Get.put(CityListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ApitestController>(builder: (controller) {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: controller.userList.length,
                      itemBuilder: (context, index) {
                        if (controller.userList != null &&
                            controller.userList.length > 0) {
                          var test = apitestController.userList.firstWhere(
                              (cityItem) =>
                                  cityItem.attributes.county ==
                                  cityListController.citys[index],
                              orElse: () => null);
                          if (test != null) {
                            print(test.attributes.county);
                          }
                          String cases =
                              ((test.attributes.cases7Per100K) as double)
                                  .toStringAsFixed(1);
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  '${cases} ${test.attributes.gen} ${test.attributes.bez}'),
                            ),
                          );
                        }
                        return Container();
                      });
                }
              }),
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
