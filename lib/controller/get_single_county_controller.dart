// @dart=2.9
import 'package:coronampel/models/county_model.dart';
import 'package:coronampel/services/county_remote_service.dart';
import 'package:get/get.dart';
import 'get_connectivity_controller.dart';

class GetSingleCountyController extends GetxController {
  final GetConnectivityController getConnectivityController =
      Get.put(GetConnectivityController());
  var isLoading = false.obs;
  var county = Data().obs;
  var selectedCountyRS = ''.obs;
  var dummydata = 'DUMYYY';

  @override
  void onInit() {
    ever(selectedCountyRS, (_) async {
      fetchCounty();
    });
    super.onInit();
  }

  Future<void> fetchCounty() async {
    isLoading(true);
    print('triggered fetch county: $selectedCountyRS');
    try {
      var countyResult =
          await RemoteServiceCounty.fetchAllCounty(selectedCountyRS);

      county.value = countyResult.data[0];
    } catch (error) {
      print(error);
      throw Exception('Failed to load single county');
    } finally {
      isLoading(false);
    }
  }
}
