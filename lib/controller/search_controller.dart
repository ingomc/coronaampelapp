import 'package:coronaampel/data/dummy_data.dart';
import 'package:coronaampel/models/city.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var citys = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCitys();
  }

  void fetchCitys() async {
    isLoading(true);
    print('triggered');
    try {
      // await Future.delayed(
      //   Duration(milliseconds: 500),
      // );
      var cityResults = DUMMY_CITYS;

      citys.assignAll(cityResults);
    } finally {
      isLoading(false);
    }
  }
}
