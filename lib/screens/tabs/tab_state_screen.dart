import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:coronaampel/controller/get_states_controller.dart';

class TabStateScreen extends StatelessWidget {
  final GetStatesController getStatesController =
      Get.put(GetStatesController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    getStatesController.isRefreshIndicatorActive.value = true;
    await getStatesController.fetchStates();
    getStatesController.isRefreshIndicatorActive.value = false;
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
                            'Stand: ${getStatesController.lastUpdate == null ? "" : getStatesController.lastUpdate}',
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ),
                      GetX<GetStatesController>(
                        builder: (controller) {
                          if (controller.states.length > 0) {
                            return Column(
                              children: [
                                ...List.generate(
                                  controller.states.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        child: Card(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: ExactAssetImage(
                                                      'assets/states/${controller.states[index].lanEwAgs}.png'),
                                                ),
                                                trailing:
                                                    IncidenceNumberContainer(
                                                        controller.states[index]
                                                            .cases7BlPer100K),
                                                title: Text(
                                                  '${controller.states[index].lanEwGen}',
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                    'Einwohner: ${NumberFormat.decimalPattern('de-DE').format(controller.states[index].lanEwEwz)}'),
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      'Neue Fälle'),
                                                                ),
                                                                Text(
                                                                  '+ ${NumberFormat.decimalPattern('de-DE').format(controller.states[index].newCases)}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    'Fälle insg.'),
                                                              ),
                                                              Text(
                                                                '${NumberFormat.decimalPattern('de-DE').format(controller.states[index].fallzahl)}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      'Neue Todesfälle'),
                                                                ),
                                                                Text(
                                                                  '+ ${controller.states[index].newDeaths}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    'Todesfälle insg.'),
                                                              ),
                                                              Text(
                                                                '${NumberFormat.decimalPattern('de-DE').format(controller.states[index].death)}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
            GetX<GetStatesController>(
              builder: (controller) {
                if (controller.isLoading.value &&
                    !controller.isRefreshIndicatorActive.value) {
                  return FadeIn(
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.black45),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
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

class IncidenceNumberContainer extends StatelessWidget {
  final double incidence;

  IncidenceNumberContainer(this.incidence);

  Color txtColor = Colors.amber;
  Color bgColor = Colors.black;

  getBgColor() {
    if (incidence < 0) {
      txtColor = Colors.white38;
      bgColor = Colors.grey[800];
      return false;
    }
    if (incidence >= 35 && incidence < 50) {
      txtColor = Colors.black54;
      bgColor = Colors.orange[300];
      return false;
    }
    if (incidence >= 50 && incidence < 100) {
      txtColor = Colors.black54;
      bgColor = Colors.redAccent[700];
      return false;
    }
    if (incidence >= 100) {
      txtColor = Colors.redAccent[700];
      bgColor = Color.fromRGBO(60, 0, 0, 1);
      return false;
    }
    txtColor = Colors.black54;
    bgColor = Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    getBgColor();
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${incidence.toStringAsFixed(1)}',
          style: TextStyle(
              color: txtColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
