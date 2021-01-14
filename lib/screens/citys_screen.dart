import 'dart:math';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:coronaampel/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  bool isRefreshIndicatorActive = false;
  final CityListController cityListController = Get.put(CityListController());
  final ApitestController apitestController = Get.put(ApitestController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    isRefreshIndicatorActive = true;
    await apitestController.fetchUsers(
      cityListController.citys,
    );
    isRefreshIndicatorActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                GetX<ApitestController>(builder: (controller) {
                  if (controller.userList != null &&
                      controller.userList.length > 0) {
                    return Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Stand: ${controller.userList[0].attributes.lastUpdate}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
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
                                        cityListController.citys[index],
                                    orElse: () => null);

                            if (user != null) {
                              return Hero(
                                tag: '${user.attributes.county}',
                                child: CityItem(
                                  user.attributes.county,
                                  user.attributes.gen,
                                  user.attributes.bez,
                                  double.parse((user.attributes.cases7Per100K)
                                      .toStringAsFixed(1)),
                                ),
                              );
                            }
                          }
                          return Container();
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
              if (!controller.isLoading.value || isRefreshIndicatorActive) {
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
