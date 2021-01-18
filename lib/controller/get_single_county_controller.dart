import 'package:get/get.dart';

class GetSingleCountyController extends GetxController {
  var isLoading = false.obs;
  var selectedCountyRS = ''.obs;
  var dummydata = 'DUMYYY';

  void onInit() {
    ever(selectedCountyRS, (_) {
      print('Selected: $selectedCountyRS');
    });
    super.onInit();
  }
}
