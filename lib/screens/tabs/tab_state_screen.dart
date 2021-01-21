import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coronaampel/controller/get_states_controller.dart';

class TabStateScreen extends StatelessWidget {
  final GetStatesController getStatesController =
      Get.put(GetStatesController());

  // Call this when the user pull down the screen
  Future<void> _loadData() async {
    // isRefreshIndicatorActive = true;
    await getStatesController.fetchStates();
    // isRefreshIndicatorActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: CupertinoScrollbar(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(12, 4, 12, 8),
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
                      if (getStatesController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (controller.states.length > 0) {
                          return Column(
                            children: [
                              ...List.generate(
                                controller.states.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: CircleAvatar(),
                                              trailing: Text(
                                                  '${controller.states[index].cases7BlPer100K.toStringAsFixed(1)}'),
                                              title: Text(
                                                '${controller.states[index].lanEwGen}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                  'Einwohlerzahl: ${controller.states[index].lanEwEwz}'),
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
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                Text('Vorne'),
                                                          ),
                                                          Text('Vorne'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    child: SizedBox(
                                                      width: 1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                Text('Hinten'),
                                                          ),
                                                          Text('Hinten'),
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
                                  );
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
    );
  }
}
