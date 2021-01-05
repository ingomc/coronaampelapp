import 'package:coronaampel/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themecontroller = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Einstellungen'),
      ),
      body: Column(
        children: [
          Container(
              child: Center(
            child: Text('Settings'),
          )),
          Container(
            child: Text(
              'System Brightness: ${Get.mediaQuery.platformBrightness.toString()}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Text(
              'Theme Brightness: ${Get.theme.brightness.toString()}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'ThemeMode',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
          Text(
            '${themecontroller.isDark}',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
          RaisedButton(
            onPressed: () {
              themecontroller.changeTheme(!themecontroller.isDark);
            },
            child: Text('Button'),
          )
        ],
      ),
    );
  }
}
