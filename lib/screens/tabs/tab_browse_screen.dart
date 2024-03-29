// @dart=2.9
import 'package:coronampel/controller/get_browse_controller.dart';
import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/get_single_county_controller.dart';
import 'package:coronampel/controller/reload_controller.dart';
import 'package:coronampel/models/browse_model.dart';
import 'package:coronampel/screens/detail/county_detail_screen.dart';
import 'package:coronampel/widgets/fund_section.dart';
import 'package:coronampel/widgets/incidence_number_container.dart';
import 'package:coronampel/widgets/loading_list_overlay.dart';
import 'package:coronampel/widgets/offline_page.dart';
import 'package:coronampel/widgets/tab_title.dart';
import 'package:coronampel/widgets/update_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matomo/matomo.dart';

class TabBrowseScreen extends TraceableStatelessWidget {
  final GetBrowseController getBrowseController =
      Get.put(GetBrowseController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());
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
            ListView.builder(
              controller: getBrowseController.scrollController,
              itemCount: 1,
              padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Obx(
                        () => UpdateLine(
                          left: ' ${getBrowseController.dateUpdated} Uhr',
                          right: getCountysController.lastUpdate.value ==
                                      null ||
                                  getCountysController.lastUpdate.value == ''
                              ? ''
                              : 'Stand: ${getCountysController.lastUpdate.value}',
                        ),
                      ),
                    ),
                    GetX<GetBrowseController>(
                      builder: (controller) {
                        if (controller.isRefreshIndicatorActive.value ==
                                false &&
                            controller.isLoading.value == true) {
                          return Container();
                        } else if (controller.lowest5.length < 1) {
                          return OfflinePage();
                        } else {
                          return FadeIn(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Hinweis: Die Farben dienen nur der schnellen Erfassung der aktuellen Inzidenz. Sie zeigen nicht an welche offizielle Corona-Maßnahmen bei euch gerade greifen.'),
                                    ),
                                  ),
                                ),
                                BrowseCard(
                                  title: 'Niedrigste Inzidenz',
                                  data: controller.lowest5,
                                  hero: hero,
                                ),
                                BrowseCard(
                                  title: 'Höchste Inzidenz',
                                  data: controller.highest5,
                                  hero: hero,
                                ),
                                BrowseCard(
                                  title: 'Meisten Einwohner*innen',
                                  data: controller.highest5Ewz,
                                  hero: hero,
                                ),
                                FundSection(),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            GetX<GetBrowseController>(
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
    );
  }
}

class BrowseCard extends StatelessWidget {
  const BrowseCard({
    Key key,
    @required this.title,
    @required this.data,
    @required this.hero,
  }) : super(key: key);

  final String title;
  final data;
  final String hero;

  @override
  Widget build(BuildContext context) {
    final GetSingleCountyController getSingleCountyController =
        Get.put(GetSingleCountyController());

    return Column(
      children: [
        TabTitle(title: title),
        GetX<GetBrowseController>(
          builder: (controller) {
            return Column(
              children: [
                ...List.generate(
                  data.length,
                  (index) {
                    BrowseCounty thisCounty = data[index];
                    return FadeIn(
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            getSingleCountyController.selectedCountyRS.value =
                                thisCounty.rs;
                            Get.to(
                                () => CountyDetailScreen(
                                      hero: hero,
                                      rs: thisCounty.rs,
                                      name: thisCounty.gen,
                                      district: thisCounty.bez,
                                      incidence: thisCounty.cases7Per100K,
                                      newCases: thisCounty.newCases,
                                    ),
                                transition: Transition.cupertino);
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                        '${thisCounty.gen} (${thisCounty.bez})'),
                                  ),
                                ),
                                IncidenceNumberContainer(
                                    thisCounty.cases7Per100K),
                              ],
                            ),
                            trailing: Icon(MdiIcons.chevronRight),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
