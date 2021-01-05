import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;
  Brightness get theme => isDark ? Brightness.dark : Brightness.light;
  // void changeTheme(bool val) => box.write('darkmode', val);
  void changeTheme(bool val) => {
        print(val),
        box.write('darkmode', val),
      };
}
