import 'package:flutter/material.dart';
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
    // isRefreshIndicatorActive = true;
    await getCountysController.fetchCountys();
    // isRefreshIndicatorActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () => Text(
                          'Stand: ${getCountysController.lastUpdate == null ? "" : getCountysController.lastUpdate}',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ),
                    GetX<PinnedCountysController>(
                      builder: (controller) {
                        if (getCountysController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (controller.countys.length > 0 &&
                              getCountysController.countys.length > 0) {
                            return Column(
                              children: [
                                ...List.generate(
                                  controller.countys.length > 100
                                      ? 100
                                      : controller.countys.length,
                                  (index) {
                                    var thisCounty = getCountysController
                                        .countys[controller.countys[index]];
                                    return CountyCard(
                                        thisCounty.rs,
                                        thisCounty.gen,
                                        thisCounty.bez,
                                        thisCounty.cases7Per100K,
                                        thisCounty.newCases);
                                  },
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Get.to(SearchScreen(), fullscreenDialog: true);
        },
      ),
    );
  }
}
