import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  final ApitestController apitestController = Get.put(ApitestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Testseite'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ApitestController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('${controller.userList[index].name}'),
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
