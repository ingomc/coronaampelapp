import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseController extends GetxController {
  final InAppPurchaseConnection iapconnection =
      InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> iapsubscription;
  static String iapproSubscriptionId = 'in_app_pro';
  static List<String> iapProductIds = <String>[iapproSubscriptionId];

  var iapnotFoundIds = [].obs; // List<String>
  var iapproducts = [].obs; // List<ProductDetails>
  var iappurchases = [].obs; // List<PurchaseDetails>
  var iapconsumables = [].obs; // List<String>
  var iapisAvailable = false.obs; // Bool
  var iappurchasePending = false.obs; // Bool
  var iaploading = true.obs; // Bool
  var iapqueryProductError = ''.obs;

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    iapsubscription = purchaseUpdated.listen((purchaseDetailsList) {
      iaplistenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      iapsubscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.onInit();
  }

  @override
  void onClose() {
    iapsubscription.cancel();
    super.onClose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await iapconnection.isAvailable();
    if (!isAvailable) {
      iapisAvailable.value = isAvailable;
      iapproducts.assignAll([]);
      iappurchases.assignAll([]);
      iapnotFoundIds.assignAll([]);
      iapconsumables.assignAll([]);
      iappurchasePending.value = false;
      iaploading.value = false;
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await iapconnection.queryProductDetails(iapProductIds.toSet());
    if (productDetailResponse.error != null) {
      iapisAvailable.value = isAvailable;
      iapproducts.assignAll(productDetailResponse.productDetails);
      iappurchases.assignAll([]);
      iapnotFoundIds.assignAll(productDetailResponse.notFoundIDs);
      iapconsumables.assignAll([]);
      iappurchasePending.value = false;
      iaploading.value = false;
      iapqueryProductError.value =
          productDetailResponse.error.message ?? 'Unbekannter Fehler';
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      iapqueryProductError.value = null;
      iapisAvailable.value = isAvailable;
      iapproducts.assignAll(productDetailResponse.productDetails);
      iappurchases.assignAll([]);
      iapnotFoundIds.assignAll(productDetailResponse.notFoundIDs);
      iapconsumables.assignAll([]);
      iappurchasePending.value = false;
      iaploading.value = false;
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await iapconnection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await iapverifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    // List<String> consumables = await ConsumableStore.load(); read from disk
    iapisAvailable.value = isAvailable;
    iapproducts.assignAll(productDetailResponse.productDetails);
    iappurchases.assignAll([verifiedPurchases]);
    iapnotFoundIds.assignAll(productDetailResponse.notFoundIDs);
    iapconsumables.assignAll([]);
    iappurchasePending.value = false;
    iaploading.value = false;
  }

  void showPendingUI() {
    iappurchasePending.value = true;
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == iapproSubscriptionId) {
      // await ConsumableStore.save(purchaseDetails.purchaseID!); save to disk
      // List<String> consumables = await ConsumableStore.load();
      List<String> consumables = [purchaseDetails.purchaseID];
      iappurchasePending.value = false;
      iapconsumables.assignAll(consumables);
    } else {
      iappurchasePending.value = false;
    }
  }

  void handleError(IAPError error) {
    print(error);
    iappurchasePending.value = false;
  }

  Future<bool> iapverifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void iaphandleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  iapverifyPurchase` failed.
  }

  void iaplistenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
          if (Platform.isIOS) {
            await InAppPurchaseConnection.instance
                .completePurchase(purchaseDetails);
          }
          Get.snackbar('Kein Kauf', 'Es wurde kein Produkt gekauft.');
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await iapverifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            iaphandleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  void buyPro(PurchaseParam purchaseParam) {
    iapconnection.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void consumePro(PurchaseDetails purchaseDetails) async {
    await InAppPurchaseConnection.instance.consumePurchase(purchaseDetails);
  }
}
