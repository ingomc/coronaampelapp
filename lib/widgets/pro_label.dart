import 'package:coronampel/controller/pro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProController proController = Get.put(ProController());
    return Obx(
      () => Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: proController.isPro.value
                    ? Colors.white
                    : Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Text(
              'PRO',
              style: TextStyle(
                  color: proController.isPro.value
                      ? Colors.white
                      : Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
