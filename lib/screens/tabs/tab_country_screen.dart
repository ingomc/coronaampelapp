import 'package:coronaampel/controller/get_global_controller.dart';
import 'package:coronaampel/widgets/incidence_number_container.dart';
import 'package:coronaampel/widgets/loading_list_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TabCountryScreen extends StatelessWidget {
  final GetGlobalController getGlobalController =
      Get.put(GetGlobalController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getGlobalController.isRefreshIndicatorActive.value = true;
    await getGlobalController.fetchGlobalData();
    getGlobalController.isRefreshIndicatorActive.value = false;
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
                padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                        child: Obx(
                          () => Text(
                            'Stand: ${getGlobalController.data.value.germany.lastUpdate == null ? "" : getGlobalController.data.value.germany.lastUpdate}',
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ),
                      GetX<GetGlobalController>(
                        builder: (controller) {
                          return Column(
                            children: [
                              // var _data = [
                              //   'assets/countries/earth.png',
                              //   'assets/countries/de.png'
                              // ];
                              Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: ExactAssetImage(
                                            'assets/countries/earth.png'),
                                      ),
                                      title: Text(
                                        'Weltweit',
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          '${NumberFormat.decimalPattern('de-DE').format(controller.data.value.global.population)}'),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: ExactAssetImage(
                                            'assets/countries/de.png'),
                                      ),
                                      trailing: IncidenceNumberContainer(
                                          controller.data.value.germany
                                              .cases7Per100K),
                                      title: Text(
                                        'Deutschland',
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          '${NumberFormat.decimalPattern('de-DE').format(controller.data.value.germany.ewz)}'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            GetX<GetGlobalController>(
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
