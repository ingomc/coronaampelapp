import 'package:flutter/material.dart';
import 'package:coronaampel/data/dummy_data.dart';
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 100),
        children: DUMMY_CITYS
            .map((cityData) => CityItem(
                  cityData.name,
                  cityData.district,
                  cityData.incidence,
                ))
            .toList(),
      ),
    );
  }
}
