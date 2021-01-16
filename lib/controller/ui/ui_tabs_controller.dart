import 'package:get/get.dart';

class UiTabsController extends GetxController {
  var _selectedIndex = 0.obs;

  get selectedIndex => this._selectedIndex.value;
  set saveSelectedIndex(index) => this._selectedIndex.value = index;
}
