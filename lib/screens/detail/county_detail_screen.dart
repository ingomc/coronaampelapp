import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/get_single_county_controller.dart';
import 'package:coronaampel/widgets/county_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountyDetailScreen extends StatelessWidget {
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final GetSingleCountyController getSingleCountyController =
      Get.put(GetSingleCountyController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    // isRefreshIndicatorActive = true;
    await getCountysController.fetchCountys();
    // isRefreshIndicatorActive = false;
  }

  @override
  Widget build(BuildContext context) {
    final countyIndex = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${getCountysController.countys[countyIndex].bez} ${getCountysController.countys[countyIndex].gen}'),
      ),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: CupertinoScrollbar(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(4, 4, 4, 32),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Hero(
                        tag: 'card$countyIndex',
                        child: CountyCard(
                            countyIndex,
                            getCountysController.countys[countyIndex].rs,
                            getCountysController.countys[countyIndex].gen,
                            getCountysController.countys[countyIndex].bez,
                            getCountysController
                                .countys[countyIndex].cases7Per100K,
                            getCountysController.countys[countyIndex].newCases,
                            false),
                      ),
                    ),
                    GetX<GetSingleCountyController>(builder: (controller) {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: <Widget>[
                                ThirdCard('Neue Fälle von Gestern',
                                    '${getCountysController.countys[countyIndex].newCases == 0 ? 0 : getCountysController.countys[countyIndex].newCases}'),
                                ThirdCard('Fälle der letzten 7 Tage',
                                    '+ ${controller.county.value.cases7Lk}'),
                                ThirdCard('Fälle insgesamt',
                                    '${controller.county.value.cases}'),
                              ],
                            ),
                          ),
                          CityDetailsRowCard('Tote bisher',
                              '${controller.county.value.deaths}'),
                          CityDetailsRowCard('Todesrate',
                              '${(controller.county.value.deathRate).toStringAsFixed(2)} %'),
                          CityDetailsRowCard('Einwohnerzahl',
                              '${controller.county.value.ewz}'),
                          CityDetailsRowCard(
                              '7 Tage Inzidenz in ${controller.county.value.bl}',
                              '${controller.county.value.cases7BlPer100K.toStringAsFixed(2)}'),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              'Intensivstation',
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ),
                          CityDetailsRowCard('Tote bisher',
                              '${controller.county.value.deaths}'),
                          CityDetailsRowCard('Todesrate',
                              '${(controller.county.value.deathRate).toStringAsFixed(2)} %'),
                          CityDetailsRowCard('Einwohnerzahl',
                              '${controller.county.value.ewz}'),
                          CityDetailsRowCard(
                              '7 Tage Inzidenz in ${controller.county.value.bl}',
                              '${controller.county.value.cases7BlPer100K.toStringAsFixed(2)}'),
                        ]);
                      }
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
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
