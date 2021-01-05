import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage('theme');
  bool get isDark => box.read('darkmode') ?? true;
  ThemeData get theme => isDark
      ? ThemeData(
          primaryColor: Colors.grey[900],
          brightness: Brightness.dark,
          accentColor: Colors.blueGrey,
        )
      : ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
        );
  void changeTheme(bool val) => box.write('darkmode', val);
}
