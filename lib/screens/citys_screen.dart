import 'dart:math';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  final CityListController cityListController = Get.put(CityListController());
  final ApitestController apitestController = Get.put(ApitestController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    await apitestController.fetchUsers(
      cityListController.citys,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: apitestController.userList.length,
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 100),
                        itemBuilder: (context, index) {
                          if (apitestController.userList != null &&
                              apitestController.userList.length > 0) {
                            Feature user = apitestController.userList
                                .firstWhere(
                                    (cityItem) =>
                                        cityItem.attributes.county ==
                                        cityListController.citys[index].county,
                                    orElse: () => null);

                            if (user != null) {
                              return CityItem(
                                user.attributes.county,
                                user.attributes.gen,
                                user.attributes.bez,
                                double.parse((user.attributes.cases7Per100K)
                                    .toStringAsFixed(1)),
                              );
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    onRefresh: _loadData,
                  ),
                ),
              ],
            ),
            // lokales is loading ist true, wenn man nach unten zieh
            // ween lokales loading false und anderes loading true is dann loading
            GetX<ApitestController>(builder: (controller) {
              if (!controller.isLoading.value) {
                return Container();
              } else {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black45),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Get.to(SearchScreen(), fullscreenDialog: true);
        },
        tooltip: 'Suche',
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
