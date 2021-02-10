import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/get_single_county_controller.dart';
import 'package:coronampel/widgets/county_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CountyDetailScreen extends StatelessWidget {
  CountyDetailScreen({
    Key key,
    @required this.hero,
    @required this.rs,
    @required this.name,
    @required this.district,
    @required this.incidence,
    @required this.newCases,
    this.isLinked = false,
  }) : super(key: key);

  final String hero;
  final String rs;
  final String name;
  final String district;
  final double incidence;
  final int newCases;
  final bool isLinked;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('$district $name'),
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
                        tag: '$hero$rs',
                        child: CountyCard(hero, rs, name, district, incidence,
                            newCases, false),
                      ),
                    ),
                    GetX<GetSingleCountyController>(builder: (controller) {
                      return FadeIn(
                        duration: Duration(milliseconds: 600),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: <Widget>[
                                  ThirdCard('Neue Fälle von Gestern',
                                      '${newCases != null && newCases > 0 ? newCases : 0}'),
                                  ThirdCard('Fälle der letzten 7 Tage',
                                      '+ ${controller.county.value.cases7Lk != null ? controller.county.value.cases7Lk : 0}'),
                                  ThirdCard('Fälle insgesamt',
                                      '${controller.county.value.cases != null ? NumberFormat.decimalPattern('de-DE').format(controller.county.value.cases) : 0}'),
                                ],
                              ),
                            ),
                            CityDetailsRowCard(
                              label: 'Tote bisher',
                              number:
                                  '${controller.county.value.deaths != null ? NumberFormat.decimalPattern('de-DE').format(controller.county.value.deaths) : 0}',
                            ),
                            CityDetailsRowCard(
                              label: 'Todesrate',
                              number:
                                  '${controller.county.value.deathRate != null ? (controller.county.value.deathRate).toStringAsFixed(2) : ""} %',
                            ),
                            CityDetailsRowCard(
                              label: 'Einwohnerzahl',
                              number:
                                  '${controller.county.value.ewz != null ? NumberFormat.decimalPattern('de-DE').format(controller.county.value.ewz) : 0}',
                            ),
                            CityDetailsRowCard(
                              label:
                                  '7 Tage Inzidenz in ${controller.county.value.bl != null ? controller.county.value.bl : ''}',
                              number:
                                  '${controller.county.value.cases7BlPer100K != null ? controller.county.value.cases7BlPer100K.toStringAsFixed(1) : ''}',
                            ),
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
                                    CityDetailsRowCard(
                                      label: 'Betten frei',
                                      percentage:
                                          '${(controller.county.value.bettenFrei / (controller.county.value.bettenFrei + controller.county.value.bettenBelegt) * 100).toStringAsFixed(0)}',
                                      number:
                                          '${controller.county.value.bettenFrei != null ? controller.county.value.bettenFrei : 0}',
                                    ),
                                    CityDetailsRowCard(
                                      label: 'Betten belegt',
                                      number:
                                          '${controller.county.value.bettenBelegt != null ? controller.county.value.bettenBelegt : 0}',
                                    ),
                                    CityDetailsRowCard(
                                      label: 'Betten belegt mit Covid-19',
                                      percentage:
                                          '${(controller.county.value.faelleCovidAktuell / (controller.county.value.faelleCovidAktuell + controller.county.value.bettenBelegt) * 100).toStringAsFixed(0)}',
                                      number:
                                          '${controller.county.value.faelleCovidAktuell != null ? controller.county.value.faelleCovidAktuell : 0}',
                                    ),
                                    CityDetailsRowCard(
                                      label:
                                          'Covid-19-Fälle die beatmet werden',
                                      number:
                                          '${controller.county.value.faelleCovidAktuellBeatmet != null ? controller.county.value.faelleCovidAktuellBeatmet : 0}',
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
  const CityDetailsRowCard({
    Key key,
    @required this.label,
    this.percentage,
    @required this.number,
  }) : super(key: key);

  final String label;
  final String number;
  final String percentage;

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
                child: Text(label),
              ),
              FadeIn(
                duration: Duration(milliseconds: 500),
                child: Text.rich(
                  TextSpan(
                    text: this.percentage == null
                        ? ''
                        : '(${this.percentage} %) ',
                    style: TextStyle(color: Theme.of(context).hintColor),
                    children: <InlineSpan>[
                      TextSpan(
                        text: ' ${this.number ?? ''}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   !getSingleCountyController.isLoading.value
                //       ? cardNumber
                //       : ' ',
                //   textAlign: TextAlign.right,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
