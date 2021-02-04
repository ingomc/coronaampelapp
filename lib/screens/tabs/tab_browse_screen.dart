import 'package:coronaampel/controller/get_browse_controller.dart';
import 'package:coronaampel/controller/get_countys_controller.dart';
import 'package:coronaampel/controller/get_single_county_controller.dart';
import 'package:coronaampel/controller/reload_controller.dart';
import 'package:coronaampel/models/browse_model.dart';
import 'package:coronaampel/screens/detail/county_detail_screen.dart';
import 'package:coronaampel/widgets/incidence_number_container.dart';
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
  final GetSingleCountyController getSingleCountyController =
      Get.put(GetSingleCountyController());
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
                      BrowseCard(
                          title: 'Niedrigste Inzidenz',
                          data: getBrowseController.lowest5,
                          hero: hero),
                      BrowseCard(
                          title: 'Höchste Inzidenz',
                          data: getBrowseController.highest5,
                          hero: hero),
                      BrowseCard(
                          title: 'Meisten Einwohner*innen',
                          data: getBrowseController.highest5Ewz,
                          hero: hero),
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
        SizedBox(
          height: 32,
        ),
        Text(
          '$title',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 16,
        ),
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
                                CountyDetailScreen(
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
                            trailing: Icon(Icons.arrow_forward_ios),
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
