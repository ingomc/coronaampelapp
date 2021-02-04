import 'package:coronaampel/controller/get_browse_controller.dart';
import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/reload_controller.dart';
import 'package:coronaampel/widgets/county_card.dart';
import 'package:coronaampel/widgets/update_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';

class TabBrowseScreen extends StatelessWidget {
  final GetBrowseController getBrowseController =
      Get.put(GetBrowseController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final ReloadController reloadController = Get.put(ReloadController());
  final String hero = 'browse';

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getBrowseController.isRefreshIndicatorActive.value = true;
    await reloadController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        backgroundColor: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            CupertinoScrollbar(
              child: ListView.builder(
                itemCount: 1,
                padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Obx(
                          () => UpdateLine(
                            left: ' ${getCountysController.dateUpdated} Uhr',
                            right:
                                'Stand: ${getCountysController.lastUpdate == null ? "" : getCountysController.lastUpdate}',
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Niedrigste Inzidenz',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: GetX<GetBrowseController>(
                                builder: (controller) {
                                  return Column(
                                    children: [
                                      ...List.generate(
                                        controller.lowest5.length,
                                        (index) {
                                          var thisCounty =
                                              controller.lowest5[index];
                                          return FadeIn(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                              child: Hero(
                                                tag: '$hero${thisCounty.rs}',
                                                child: CountyCard(
                                                    hero,
                                                    thisCounty.rs,
                                                    thisCounty.gen,
                                                    thisCounty.bez,
                                                    thisCounty.cases7Per100K,
                                                    thisCounty.newCases),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
