import 'package:coronampel/controller/get_location_controller.dart';
import 'package:coronampel/controller/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/pinned_countys_controller.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final PinnedCountysController pinnedCountysController =
      Get.put(PinnedCountysController());
  final SearchController searchController = Get.put(SearchController());
  final GetLocationController getLocationController =
      Get.put(GetLocationController());

  Future<bool> _onWillPop() async {
    Get.back();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Obx(
                  () => TextField(
                    autocorrect: false,
                    autofocus: true,
                    controller: TextEditingController.fromValue(
                      new TextEditingValue(
                        text: searchController.searchString.value,
                        selection: TextSelection.collapsed(
                            offset: searchController.searchString.value.length),
                      ),
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.amber,
                      contentPadding: EdgeInsets.all(16),
                      hintText: "Landkreis Suchen ...",
                      border: InputBorder.none,
                    ),
                    onChanged: (String keyword) {
                      searchController.searchString.value = keyword;
                    },
                  ),
                ),
              ),
              GetX<SearchController>(builder: (controller) {
                if (searchController.searchString.value.length > 0) {
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      searchController.searchString.value = '';
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
              ),
              Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetX<GetLocationController>(builder: (controller) {
                      if (controller.isLoading.value) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ),
                          onPressed: () {},
                          child: Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 2,
                              ),
                              width: 16,
                              height: 16,
                            ),
                          ),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ),
                        onPressed: () {
                          getLocationController.getLocation();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.gps_fixed),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Aktuelle Position verwenden'),
                          ],
                        ),
                      );
                    }),
                  )),
              Expanded(
                child: GetX<GetCountysController>(builder: (controller) {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    );
                  } else {
                    return CupertinoScrollbar(
                      child: ListView.builder(
                        itemCount: controller.countys.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () {
                              if (searchController.searchString.value.length >
                                      1 &&
                                  controller.countys[index].gen
                                      .toLowerCase()
                                      .contains(searchController
                                          .searchString.value
                                          .trim()
                                          .toLowerCase())) {
                                return Card(
                                  // Material ripple effect
                                  child: InkWell(
                                    onTap: () {
                                      pinnedCountysController
                                          .toggleCounty(index);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          '${controller.countys[index].bez} ${controller.countys[index].gen}'),
                                      subtitle: Text(
                                          'Inzidenz: ${controller.countys[index].cases7Per100K ??= 0} | Neue Fälle: ${controller.countys[index].newCases ??= 0}'),
                                      trailing: isFavorite(index, context),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isFavorite(int index, BuildContext context) {
    if (pinnedCountysController.countys.contains(index)) {
      return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1100),
        tween: Tween<double>(begin: -1, end: 0),
        curve: Curves.elasticOut,
        builder: (_, double angle, __) {
          return Transform.rotate(
            angle: angle,
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        },
      );
    } else {
      return Icon(Icons.add);
    }
  }
}
