import 'package:coronaampel/controller/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:coronaampel/data/dummy_data.dart';
import 'package:get/get.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  void _select(value) {
    switch (value) {
      case 'Entfernen':
        break;
      case 'Anpassen':
        break;
    }
    print(value);
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
              child: GetX<TestController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.citys.length,
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 100),
                  itemBuilder: (context, index) {
                    return CityItem(
                      controller.citys[index].name,
                      controller.citys[index].district,
                      controller.citys[index].incidence,
                    );
                    //             cityData.name,
                    //             cityData.district,
                    //             cityData.incidence,
                    //           )
                    // return Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Text(
                    //         '${controller.citys[index].name} ${controller.citys[index].district} '),
                    //   ),
                    // );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      // body: ListView(
      //   physics: BouncingScrollPhysics(),
      //   children: DUMMY_CITYS
      //       .map((cityData) => CityItem(
      //             cityData.name,
      //             cityData.district,
      //             cityData.incidence,
      //           ))
      //       .toList(),
      // ),
    );
  }
}
