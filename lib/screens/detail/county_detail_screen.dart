import 'package:flutter_fadein/flutter_fadein.dart';
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
                    SizedBox(height: 4),
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
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: <Widget>[
                                ThirdCard('Neue Fälle von Gestern',
                                    '${getCountysController.countys[countyIndex].newCases > 0 ? getCountysController.countys[countyIndex].newCases : 0}'),
                                ThirdCard('Fälle der letzten 7 Tage',
                                    '+ ${controller.county.value.cases7Lk != null ? controller.county.value.cases7Lk : 0}'),
                                ThirdCard('Fälle insgesamt',
                                    '${controller.county.value.cases != null ? controller.county.value.cases : 0}'),
                              ],
                            ),
                          ),
                          CityDetailsRowCard('Tote bisher',
                              '${controller.county.value.deaths != null ? controller.county.value.deaths : 0}'),
                          CityDetailsRowCard('Todesrate',
                              '${controller.county.value.deathRate != null ? (controller.county.value.deathRate).toStringAsFixed(2) : ""} %'),
                          CityDetailsRowCard('Einwohnerzahl',
                              '${controller.county.value.ewz != null ? controller.county.value.ewz : 0}'),
                          CityDetailsRowCard(
                              '7 Tage Inzidenz in ${controller.county.value.bl != null ? controller.county.value.bl : ''}',
                              '${controller.county.value.cases7BlPer100K != null ? controller.county.value.cases7BlPer100K.toStringAsFixed(2) : ''}'),
                          SizedBox(
                            height: 16,
                          ),
                          if (controller.isLoading.value)
                            FadeIn(
                              duration: Duration(milliseconds: 500),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          if (!controller.isLoading.value &&
                              controller.county.value.bettenFrei != null)
                            FadeIn(
                              duration: Duration(milliseconds: 500),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Intensivstation',
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CityDetailsRowCard('Betten frei',
                                      '${controller.county.value.bettenFrei != null ? controller.county.value.bettenFrei : 0}'),
                                  CityDetailsRowCard('Betten belegt',
                                      '${controller.county.value.bettenBelegt != null ? controller.county.value.bettenBelegt : 0}'),
                                  CityDetailsRowCard(
                                      'Betten belegt mit Covid-19',
                                      '${controller.county.value.faelleCovidAktuell != null ? controller.county.value.faelleCovidAktuell : 0}'),
                                  CityDetailsRowCard(
                                      'Covid-19-Fälle die beatmet werden',
                                      '${controller.county.value.faelleCovidAktuellBeatmet != null ? controller.county.value.faelleCovidAktuellBeatmet : 0}'),
                                ],
                              ),
                            ),
                        ],
                      );
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
  final GetSingleCountyController getSingleCountyController = Get.find();
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
                Obx(
                  () => FadeIn(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      !getSingleCountyController.isLoading.value
                          ? cardNumber
                          : ' ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
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
  final GetSingleCountyController getSingleCountyController = Get.find();

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
              Obx(
                () => FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    !getSingleCountyController.isLoading.value
                        ? cardNumber
                        : ' ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
