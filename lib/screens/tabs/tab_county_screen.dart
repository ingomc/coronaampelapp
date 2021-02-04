import 'package:coronaampel/controller/reload_controller.dart';
import 'package:coronaampel/widgets/loading_list_overlay.dart';
import 'package:coronaampel/widgets/update_line.dart';
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
  final ReloadController reloadController = Get.put(ReloadController());
  final String hero = 'county';

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getCountysController.isRefreshIndicatorActive.value = true;
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
                physics: const AlwaysScrollableScrollPhysics(),
                controller: getCountysController.scrollController,
                padding: EdgeInsets.fromLTRB(12, 4, 12, 100),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Obx(
                          () => (pinnedCountysController.countys.length > 0)
                              ? FadeIn(
                                  child: UpdateLine(
                                    left:
                                        ' ${getCountysController.dateUpdated} Uhr',
                                    right:
                                        'Stand: ${getCountysController.lastUpdate == null ? "" : getCountysController.lastUpdate}',
                                  ),
                                )
                              : Container(),
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
                                    return FadeIn(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
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
                          } else {
                            return Opacity(
                              opacity: .3,
                              child: Padding(
                                padding: const EdgeInsets.all(36.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(36.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(28.0),
                                            child: Icon(
                                              Icons.add,
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text('Landkreise Suche',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Suche deine Landkreise und füge sie deiner Liste hinzu',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
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
          Get.to(SearchScreen(), transition: Transition.downToUp);
        },
      ),
    );
  }
}
