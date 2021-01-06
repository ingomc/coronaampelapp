import 'package:coronaampel/controller/search_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final searchController = Get.put(SearchController());
  final citysController = Get.put(CitysController());

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
                        citysController
                            .toggleCityToList(controller.citys[index]);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  '${controller.citys[index].district} ${controller.citys[index].name}'),
                              subtitle: Text(
                                  'Aktuelle Inzidenz: ${controller.citys[index].incidence}'),
                              trailing: Obx(() => isFavorite(index, context)),
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

  Widget isFavorite(int index, BuildContext context) {
    if (citysController.citys.firstWhere(
            (city) => city.id == searchController.citys[index].id,
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
