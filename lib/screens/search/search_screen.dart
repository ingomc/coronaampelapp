import 'package:coronaampel/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/pinned_countys_controller.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final PinnedCountysController pinnedCountysController =
      Get.put(PinnedCountysController());
  final SearchController searchController = Get.put(SearchController());

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
          title: Text('Suche'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        autofocus: true,
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
                    Icon(
                      Icons.search,
                    )
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Aktuelle Position verwenden'),
                    ),
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
                    return Scrollbar(
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
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return Icon(Icons.add);
    }
  }
}
