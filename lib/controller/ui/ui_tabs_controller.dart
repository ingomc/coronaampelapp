import 'package:get/get.dart';
import 'package:matomo/matomo.dart';

class UiTabsController extends GetxController {
  var selectedIndex = 0.obs;

  set saveSelectedIndex(index) => this.selectedIndex.value = index;

  @override
  void onInit() {
    // MatomoTracker().setOptOut(true);
    // MatomoTracker().clear();
    super.onInit();
  }
}
