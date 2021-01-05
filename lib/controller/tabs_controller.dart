import 'package:get/get.dart';

class TabsController extends GetxController {
  var _selectedIndex = 0.obs;

  get selectedIndex => this._selectedIndex.value;
  set selectedIndex(index) => this._selectedIndex.value = index;
}
