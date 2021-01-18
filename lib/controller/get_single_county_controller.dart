import 'package:get/get.dart';

class GetSingleCountyController extends GetxController {
  var isLoading = false.obs;
  var dummydata = 'DUMYYY';

  @override
  void onReady() {
    print('Fetch on ready city');
    super.onReady();
  }

  void onInit() {
    print('Fetch city');
    super.onInit();
  }
}
