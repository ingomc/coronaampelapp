import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  final citysController = Get.put(CitysController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Einstellungen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<CitysController>(builder: (controller) {
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
