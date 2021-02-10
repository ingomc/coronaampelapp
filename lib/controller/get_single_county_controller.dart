import 'package:coronampel/models/county_model.dart';
import 'package:coronampel/services/county_remote_service.dart';
import 'package:get/get.dart';

class GetSingleCountyController extends GetxController {
  var isLoading = false.obs;
  var county = Data().obs;
  var selectedCountyRS = ''.obs;
  var dummydata = 'DUMYYY';

  void onInit() {
    ever(selectedCountyRS, (_) async {
      isLoading(true);
      print('triggered fetch county: $selectedCountyRS');
      try {
        var countyResult =
            await RemoteServiceCounty.fetchAllCounty(selectedCountyRS);

        county.value = countyResult.data[0];
      } catch (error) {
        print(error);
        throw Exception('Failed to load all countys');
      } finally {
        isLoading(false);
      }
    });
    super.onInit();
  }
}
