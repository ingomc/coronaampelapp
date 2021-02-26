import 'package:coronampel/controller/pro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Devtools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProController proController = Get.put(ProController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Devtools'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              child: Obx(
                () => SwitchListTile(
                  title: Text('Pro'),
                  value: proController.isPro.value,
                  onChanged: (bool value) {
                    proController.isPro.value = !(proController.isPro.value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
