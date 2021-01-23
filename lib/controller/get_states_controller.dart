import 'package:get/get.dart';
// import 'package:coronaampel/data/dummy_data.dart';
import 'package:coronaampel/models/states_model.dart';
import 'package:coronaampel/services/states_remote_service.dart';

class GetStatesController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  var states = States().locations.obs;
  var lastUpdate = States().lastUpdate.obs;

  @override
  void onInit() {
    fetchStates();
    super.onInit();
  }

  Future<void> fetchStates() async {
    isLoading(true);
    print('triggered fetch all states');
    try {
      // DUMMY CONTNENT ----------------- //
      // await Future.delayed(
      //   Duration(milliseconds: 2000),
      // );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var statesResult = await RemoteServiceStates.fetchAllStates();

      states.assignAll(statesResult.locations);
      lastUpdate.value = statesResult.lastUpdate;
    } catch (error) {
      print(error);
      throw Exception('Failed to load all states');
    } finally {
      isLoading(false);
    }
  }
}
