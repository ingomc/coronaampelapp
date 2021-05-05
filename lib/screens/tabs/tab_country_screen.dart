// @dart=2.9
import 'package:coronampel/controller/get_global_controller.dart';
import 'package:coronampel/controller/reload_controller.dart';
import 'package:coronampel/widgets/offline_page.dart';
import 'package:coronampel/widgets/incidence_number_container.dart';
import 'package:coronampel/widgets/loading_list_overlay.dart';
import 'package:coronampel/widgets/update_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matomo/matomo.dart';

class TabCountryScreen extends TraceableStatelessWidget {
  final GetGlobalController getGlobalController =
      Get.put(GetGlobalController());

  final ReloadController reloadController = Get.put(ReloadController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getGlobalController.isRefreshIndicatorActive.value = true;
    await reloadController.reload();
  }

// Optional: Set the option to disable the personalized Ads. AdMob default option: personalized

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
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Obx(
                          () => UpdateLine(
                            left: ' ${getGlobalController.dateUpdated} Uhr',
                            right: getGlobalController.data.value.germany ==
                                    null
                                ? ''
                                : 'Stand: ${getGlobalController.data.value.germany.lastUpdate}',
                          ),
                        ),
                      ),
                      GetX<GetGlobalController>(
                        builder: (controller) {
                          if (controller.data.value.germany == null) {
                            return OfflinePage();
                          }
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Card(
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
                                            'Bevölkerung: ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.global.population)}'),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                    'Alle Fälle insgesamt'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '${NumberFormat.decimalPattern('de-DE').format(controller.data.value.global.cases)}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                          ),
                                        ),
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16.0),
                                                child: Column(
                                                  children: [
                                                    Text('Neue Fälle'),
                                                    Text(
                                                      '+ ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.global.todayCases)} ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16.0),
                                                child: Column(
                                                  children: [
                                                    Text('Neue Todesfälle'),
                                                    Text(
                                                      '+ ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.global.todayDeaths)} ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                          'Bevölkerung: ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.germany.ewz)}'),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child:
                                                  Text('Alle Fälle insgesamt'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              '${NumberFormat.decimalPattern('de-DE').format(controller.data.value.germany.cases)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16.0),
                                              child: Column(
                                                children: [
                                                  Text('Neue Fälle'),
                                                  Text(
                                                    '+ ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.germany.newCases)} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            thickness: 1,
                                            width: 1,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16.0),
                                              child: Column(
                                                children: [
                                                  Text('Neue Todesfälle'),
                                                  Text(
                                                    '+ ${NumberFormat.decimalPattern('de-DE').format(controller.data.value.germany.newDeaths)} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
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
