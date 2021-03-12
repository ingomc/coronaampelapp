import 'package:coronampel/controller/get_browse_controller.dart';
import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/get_single_county_controller.dart';
import 'package:coronampel/controller/in_app_purchase_controller.dart';
import 'package:coronampel/controller/pro_controller.dart';
import 'package:coronampel/controller/reload_controller.dart';
import 'package:coronampel/models/browse_model.dart';
import 'package:coronampel/screens/detail/county_detail_screen.dart';
import 'package:coronampel/widgets/incidence_number_container.dart';
import 'package:coronampel/widgets/loading_list_overlay.dart';
import 'package:coronampel/widgets/offline_page.dart';
import 'package:coronampel/widgets/tab_title.dart';
import 'package:coronampel/widgets/update_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class TabBrowseScreen extends StatelessWidget {
  final InAppPurchaseController inAppPurchaseController =
      Get.put(InAppPurchaseController());
  final GetBrowseController getBrowseController =
      Get.put(GetBrowseController());
  final ProController proController = Get.put(ProController());
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
            CupertinoScrollbar(
              child: ListView.builder(
                controller: getBrowseController.scrollController,
                itemCount: 1,
                padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Obx(
                        () => Text(inAppPurchaseController.iaploading.value
                            ? 'Loading ...................'
                            : 'not loading'),
                      ),
                      Obx(
                        () => Text(!inAppPurchaseController.iaploading.value &&
                                inAppPurchaseController.iapisAvailable.value
                            ? 'Store ist da ✅'
                            : '❌'),
                      ),
                      Obx(
                        () => Text(
                            inAppPurchaseController.iappurchasePending.value
                                ? 'iappurchasePending ...'
                                : 'NOT iappurchasePending ❌'),
                      ),
                      Obx(
                        () => Text(inAppPurchaseController.iaploading.value
                            ? 'iaploading ...'
                            : 'NOT iaploading ❌'),
                      ),
                      Obx(
                        () => Text((inAppPurchaseController
                                    .iapqueryProductError.value.length >
                                0)
                            ? 'ERROR❌: ${inAppPurchaseController.iapqueryProductError.value}'
                            : 'NO ERROR'),
                      ),
                      // noz found
                      Obx(
                        () => Column(
                          children: [
                            SizedBox(height: 32),
                            Text(
                              'Not found ids',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(
                              inAppPurchaseController.iapnotFoundIds.length,
                              (index) {
                                String thisId = inAppPurchaseController
                                    .iapnotFoundIds[index];
                                return Card(
                                  child: Text('$thisId'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // iapproducts
                      Obx(
                        () => Column(
                          children: [
                            SizedBox(height: 32),
                            Text(
                              'IAPProducts',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(
                              inAppPurchaseController.iapproducts.length,
                              (index) {
                                ProductDetails thisId =
                                    inAppPurchaseController.iapproducts[index];
                                return Card(
                                  child: Column(
                                    children: [
                                      Text('id: ${thisId.id}'),
                                      Text(
                                          'description: ${thisId.description}'),
                                      Text('title: ${thisId.title}'),
                                      Text(
                                          'price: ${thisId.price} + 19% MwSt.'),
                                      ElevatedButton(
                                        onPressed: () {
                                          PurchaseParam purchaseParam =
                                              PurchaseParam(
                                            productDetails: thisId,
                                            applicationUserName: null,
                                          );
                                          inAppPurchaseController
                                              .buyPro(purchaseParam);
                                        },
                                        child: Text('Kaufen: ${thisId.title}'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          PurchaseDetails purchaseDetails =
                                              inAppPurchaseController
                                                  .iappurchases[0][0];
                                          inAppPurchaseController
                                              .consumePro(purchaseDetails);
                                        },
                                        child: Text(
                                            'Konsumieren: ${thisId.title}'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // iappurchases
                      Obx(
                        () => Column(
                          children: [
                            SizedBox(height: 32),
                            Text(
                              'iappurchases',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(
                              inAppPurchaseController.iappurchases.length,
                              (index) {
                                List<PurchaseDetails> purchaseList =
                                    inAppPurchaseController.iappurchases[index];
                                return Column(
                                  children: [
                                    ...List.generate(
                                      purchaseList.length,
                                      (index) {
                                        PurchaseDetails thisId =
                                            purchaseList[index];
                                        return Card(
                                          child: Column(
                                            children: [
                                              Text(
                                                  'productid: ${thisId.productID}'),
                                              Text(
                                                  'purchaseID: ${thisId.purchaseID}'),
                                              Text(
                                                  'purchaseID: ${thisId.transactionDate}'),
                                              Text(
                                                  'purchaseID: ${thisId.verificationData.serverVerificationData}'),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // iapconsumables
                      Obx(
                        () => Column(
                          children: [
                            SizedBox(height: 32),
                            Text(
                              'iapconsumables',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(
                              inAppPurchaseController.iapconsumables.length,
                              (index) {
                                String thisId = inAppPurchaseController
                                    .iapconsumables[index];
                                return Card(
                                  child: Text('iapconsumables $thisId'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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
                                  BrowseCard(
                                      title: 'Niedrigste Inzidenz',
                                      data: controller.lowest5,
                                      hero: hero),
                                  BrowseCard(
                                      title: 'Höchste Inzidenz',
                                      data: controller.highest5,
                                      hero: hero),
                                  BrowseCard(
                                      title: 'Meisten Einwohner*innen',
                                      data: controller.highest5Ewz,
                                      hero: hero),
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
