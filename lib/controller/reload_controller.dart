import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'get_countys_controller.dart';
import 'get_global_controller.dart';
import 'get_states_controller.dart';

class ReloadController extends GetxController {
  final GetStatesController getStatesController =
      Get.put(GetStatesController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final GetGlobalController getGlobalController =
      Get.put(GetGlobalController());

  Future<void> reload() async {
    Future.wait([
      getStatesController.fetchStates(),
      getCountysController.fetchCountys(),
      getGlobalController.fetchGlobalData()
    ]);
  }
}
