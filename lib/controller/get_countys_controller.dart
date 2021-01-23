import 'package:get/get.dart';
// import 'package:coronaampel/data/dummy_data.dart';
import 'package:coronaampel/models/countys_model.dart';
import 'package:coronaampel/services/countys_remote_service.dart';

class GetCountysController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  var countys = [].obs;
  var lastUpdate = ''.obs;

  @override
  void onInit() {
    fetchCountys();
    super.onInit();
  }

  Future<void> fetchCountys() async {
    isLoading(true);
    print('triggered fetch all countys');
    try {
      // DUMMY CONTNENT ----------------- //
      await Future.delayed(
        Duration(milliseconds: 2000),
      );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var countysResult = await RemoteServiceCountys.fetchAllCountys();

      countys.assignAll(countysResult.locations);
      lastUpdate.value = countysResult.date;
    } catch (error) {
      print(error);
      throw Exception('Failed to load all countys');
    } finally {
      isLoading(false);
    }
  }
}
