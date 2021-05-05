// @dart=2.9
import 'package:coronampel/controller/get_browse_controller.dart';
import 'package:coronampel/controller/get_connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'get_countys_controller.dart';
import 'get_global_controller.dart';
import 'get_states_controller.dart';
import 'get_vaccine_controller.dart';

class ReloadController extends GetxController {
  final GetStatesController getStatesController =
      Get.put(GetStatesController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());
  final GetGlobalController getGlobalController =
      Get.put(GetGlobalController());
  final GetVaccineController getVaccineController =
      Get.put(GetVaccineController());
  final GetBrowseController getBrowseController =
      Get.put(GetBrowseController());
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());

  @override
  void onInit() {
    reload();
    super.onInit();
  }

  Future<void> reload() async {
    await Future.wait([
      getStatesController.fetchStates(),
      getCountysController.fetchCountys(),
      getGlobalController.fetchGlobalData(),
      getVaccineController.fetchVaccine(),
      getBrowseController.fetchBrowse(),
    ]);
  }
}
