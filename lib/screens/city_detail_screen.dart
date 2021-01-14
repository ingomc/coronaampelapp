import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:coronaampel/items/city_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityDetailScreen extends StatelessWidget {
  static const path = '/city';
  final ApitestController apitestController = Get.put(ApitestController());

  @override
  Widget build(BuildContext context) {
    final cityCounty = ModalRoute.of(context).settings.arguments as String;
    final city = apitestController.userList
        .firstWhere((city) => city.attributes.county == cityCounty);

    return Scaffold(
      appBar: AppBar(
        title: Text('${city.attributes.bez} ${city.attributes.gen}'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Hero(
              tag: '${city.attributes.county}',
              child: CityItem(
                  city.attributes.county,
                  city.attributes.gen,
                  city.attributes.bez,
                  double.parse(
                      (city.attributes.cases7Per100K).toStringAsFixed(1)),
                  false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: <Widget>[
                ThirdCard('Neue Fälle von Gestern', '-'),
                ThirdCard('Fälle der letzten 7 Tage',
                    '+ ${city.attributes.cases7Lk.toString()}'),
                ThirdCard('Fälle insgesamt', '${city.attributes.cases}'),
              ],
            ),
          ),
          CityDetailsRowCard('Tote bisher', '${city.attributes.deaths}'),
          CityDetailsRowCard('Todesrate',
              '${(city.attributes.deathRate).toStringAsFixed(2)} %'),
          CityDetailsRowCard('Einwohnerzahl', '${city.attributes.ewz}'),
          CityDetailsRowCard('7 Tage Inzidenz in ${city.attributes.bl}',
              '${city.attributes.cases7BlPer100K.toStringAsFixed(1)}'),
        ],
      )),
    );
  }
}

class ThirdCard extends StatelessWidget {
  final String cardTitle;
  final String cardNumber;

  ThirdCard(this.cardTitle, this.cardNumber);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(
              children: [
                Container(
                  height: 32,
                  child: Text(
                    cardTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  cardNumber,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CityDetailsRowCard extends StatelessWidget {
  final String cardTitle;
  final String cardNumber;

  CityDetailsRowCard(this.cardTitle, this.cardNumber);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(cardTitle),
              ),
              Text(
                cardNumber,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
