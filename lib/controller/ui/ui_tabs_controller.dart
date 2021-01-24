import 'package:get/get.dart';

class UiTabsController extends GetxController {
  var selectedIndex = 0.obs;

  set saveSelectedIndex(index) => this.selectedIndex.value = index;
}
