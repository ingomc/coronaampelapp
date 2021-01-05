import 'package:coronaampel/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themecontroller = Get.put(ThemeController());
    return SimpleBuilder(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Einstellungen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                  child: Text('Settings',
                      style: Theme.of(context).textTheme.headline6)),
              Center(
                child: SwitchListTile(
                  value: themecontroller.isDark,
                  title: Text("Darkmode"),
                  onChanged: themecontroller.changeTheme,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
