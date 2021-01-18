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
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: CupertinoScrollbar(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Hero(
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
                    Center(
                      child: Text(getSingleCountyController.dummydata),
                    ),
                    Center(
                      child:
                          Text('${getSingleCountyController.selectedCountyRS}'),
                    ),
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
