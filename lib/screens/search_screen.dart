import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/search_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final searchController = Get.put(SearchController());
  final cityListController = Get.put(CityListController());
  final apitestController = Get.put(ApitestController());

  Future<bool> _onWillPop() async {
    print('Backbutton');
    // try {
    //   await apitestController.fetchUsers(
    //     cityListController.citys,
    //   );
    // } catch (err) {
    //   print('searchscreen');
    //   print(err);
    // } finally {
    //   Get.back();
    // }
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
              Expanded(
                child: GetX<SearchController>(builder: (controller) {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.citys.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            cityListController.toggleCityToList(
                                controller.citys[index].county);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      '${controller.citys[index].district} ${controller.citys[index].name}'),
                                  subtitle: Text(
                                      'Aktuelle Inzidenz: ${controller.citys[index].incidence}'),
                                  trailing:
                                      Obx(() => isFavorite(index, context)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
    if (cityListController.citys.firstWhere(
            (city) => city == searchController.citys[index].county,
            orElse: () => null) !=
        null) {
      //if val is true
      return Icon(
        Icons.check,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.green
            : Colors.green[700],
      );
    } else {
      return Icon(Icons.add);
    }
  }
}
