import 'package:coronaampel/widgets/loading_list_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:coronaampel/controller/pinned_countys_controller.dart';
import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/screens/search/search_screen.dart';
import 'package:coronaampel/widgets/county_card.dart';

class TabCountyScreen extends StatelessWidget {
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final PinnedCountysController pinnedCountysController =
      Get.put(PinnedCountysController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getCountysController.isRefreshIndicatorActive.value = true;
    await getCountysController.fetchCountys();
    getCountysController.isRefreshIndicatorActive.value = false;
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
                padding: EdgeInsets.fromLTRB(12, 4, 12, 100),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                        child: GetX<PinnedCountysController>(
                          builder: (controller) {
                            if (getCountysController.countys.length > 0 &&
                                controller.countys.length > 0) {
                              return Text(
                                'Stand: ${getCountysController.lastUpdate == null ? "" : getCountysController.lastUpdate}',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      GetX<PinnedCountysController>(
                        builder: (controller) {
                          if (getCountysController.countys.length > 0 &&
                              controller.countys.length > 0) {
                            return Column(
                              children: [
                                ...List.generate(
                                  controller.countys.length > 100
                                      ? 100
                                      : controller.countys.length,
                                  (index) {
                                    var thisCounty = getCountysController
                                        .countys[controller.countys[index]];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Hero(
                                        tag: 'card${controller.countys[index]}',
                                        child: CountyCard(
                                            controller.countys[index],
                                            thisCounty.rs,
                                            thisCounty.gen,
                                            thisCounty.bez,
                                            thisCounty.cases7Per100K,
                                            thisCounty.newCases),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            GetX<GetCountysController>(
              builder: (controller) {
                if (controller.isLoading.value &&
                    !controller.isRefreshIndicatorActive.value) {
                  return LoadingListOverlay();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(SearchScreen(), fullscreenDialog: true);
        },
      ),
    );
  }
}
