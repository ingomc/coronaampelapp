import 'package:coronaampel/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';
  final searchController = Get.put(SearchController());

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
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            '${controller.citys[index].name} ${controller.citys[index].district} '),
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
}
