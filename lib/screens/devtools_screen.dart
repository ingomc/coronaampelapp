import 'package:coronampel/controller/in_app_purchase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:matomo/matomo.dart';

class Devtools extends TraceableStatelessWidget {
  @override
  Widget build(BuildContext context) {
    InAppPurchaseController inAppPurchaseController =
        Get.put(InAppPurchaseController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Devtools'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Card(
                child: Obx(
                  () => SwitchListTile(
                    title: Text(
                        'Is Pro ${inAppPurchaseController.isPurchased.value.toString()}'),
                    value: inAppPurchaseController.isPurchased.value,
                    onChanged: (bool value) {
                      inAppPurchaseController.isPurchased.value =
                          !(inAppPurchaseController.isPurchased.value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Obx(
              () => Text(inAppPurchaseController.isPurchased.value
                  ? 'purhcased'
                  : 'not...'),
            ),
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
              () => Text(inAppPurchaseController.iappurchasePending.value
                  ? 'iappurchasePending ...'
                  : 'NOT iappurchasePending ❌'),
            ),
            Obx(
              () => Text(inAppPurchaseController.iaploading.value
                  ? 'iaploading ...'
                  : 'NOT iaploading ❌'),
            ),
            Obx(
              () => Text((inAppPurchaseController.iapqueryProductError.value !=
                      null)
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
                      String thisId =
                          inAppPurchaseController.iapnotFoundIds[index];
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
                            Text('description: ${thisId.description}'),
                            Text('title: ${thisId.title}'),
                            Text('price: ${thisId.price} + 19% MwSt.'),
                            ElevatedButton(
                              onPressed: () {
                                PurchaseParam purchaseParam = PurchaseParam(
                                  productDetails: thisId,
                                  applicationUserName: null,
                                );
                                inAppPurchaseController.buyPro(purchaseParam);
                              },
                              child: Text('Kaufen: ${thisId.title}'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                PurchaseDetails purchaseDetails =
                                    inAppPurchaseController.iappurchases[0][0];
                                inAppPurchaseController
                                    .consumePro(purchaseDetails);
                              },
                              child: Text('Konsumieren: ${thisId.title}'),
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
                              PurchaseDetails thisId = purchaseList[index];
                              return Card(
                                child: Column(
                                  children: [
                                    Text('productid: ${thisId.productID}'),
                                    Text('purchaseID: ${thisId.purchaseID}'),
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
                      String thisId =
                          inAppPurchaseController.iapconsumables[index];
                      return Card(
                        child: Text('iapconsumables $thisId'),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 64),
          ],
        ),
      ]),
    );
  }
}
