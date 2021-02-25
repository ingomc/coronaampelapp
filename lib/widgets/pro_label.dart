import 'package:coronampel/controller/pro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProController proController = Get.put(ProController());
    return Obx(
      () => proController.isPro.value
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  child: Text('PRO'),
                ),
              ),
            )
          : Container(),
    );
  }
}
