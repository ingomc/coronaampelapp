import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseController extends GetxController {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  static String _proSubscriptionId = 'in_app_pro';
  static List<String> _ProductIds = <String>[_proSubscriptionId];

  var _notFoundIds = [].obs; // List<String>
  var _products = [].obs; // List<ProductDetails>
  var _purchases = [].obs; // List<PurchaseDetails>
  var _consumables = [].obs; // List<String>
  var _isAvailable = false.obs; // Bool
  var _purchasePending = false.obs; // Bool
  var _loading = true.obs; // Bool
  var _queryProductError = ''.obs;

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.onInit();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      _isAvailable.value = isAvailable;
      _products.assignAll([]);
      _purchases.assignAll([]);
      _notFoundIds.assignAll([]);
      _consumables.assignAll([]);
      _purchasePending.value = false;
      _loading.value = false;
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_ProductIds.toSet());
    if (productDetailResponse.error != null) {
      _isAvailable.value = isAvailable;
      _products.assignAll(productDetailResponse.productDetails);
      _purchases.assignAll([]);
      _notFoundIds.assignAll(productDetailResponse.notFoundIDs);
      _consumables.assignAll([]);
      _purchasePending.value = false;
      _loading.value = false;
      _queryProductError.value = productDetailResponse.error.message;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      _queryProductError.value = null;
      _isAvailable.value = isAvailable;
      _products.assignAll(productDetailResponse.productDetails);
      _purchases.assignAll([]);
      _notFoundIds.assignAll(productDetailResponse.notFoundIDs);
      _consumables.assignAll([]);
      _purchasePending.value = false;
      _loading.value = false;
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    // List<String> consumables = await ConsumableStore.load(); read from disk
    _isAvailable.value = isAvailable;
    _products.assignAll(productDetailResponse.productDetails);
    _purchases.assignAll([verifiedPurchases]);
    _notFoundIds.assignAll(productDetailResponse.notFoundIDs);
    _consumables.assignAll([]);
    _purchasePending.value = false;
    _loading.value = false;
  }

  void showPendingUI() {
    _purchasePending.value = true;
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _proSubscriptionId) {
      // await ConsumableStore.save(purchaseDetails.purchaseID!); save to disk
      // List<String> consumables = await ConsumableStore.load();
      List<String> consumables = [purchaseDetails.purchaseID];
      _purchasePending.value = false;
      _consumables.assignAll(consumables);
    } else {
      _purchasePending.value = false;
    }
  }

  void handleError(IAPError error) {
    print(error);
    _purchasePending.value = false;
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
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
}
