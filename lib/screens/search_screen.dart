import 'package:coronaampel/controller/search_controller.dart';
import 'package:coronaampel/controller/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final searchController = Get.put(SearchController());
  final testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suche'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<SearchController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.citys.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        testController.addCity(controller.citys[index]);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        '${controller.citys[index].name} ${controller.citys[index].district} in Liste?'),
                                  ),
                                  Obx(() => isFavorite(index)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget isFavorite(int index) {
    if (testController.citys.firstWhere(
            (city) => city.id == searchController.citys[index].id,
            orElse: () => null) !=
        null) {
      //if val is true
      return Icon(
        Icons.check,
        color: Colors.greenAccent,
      );
    } else {
      return Icon(Icons.add);
      //if val is false
    }
  }
}
