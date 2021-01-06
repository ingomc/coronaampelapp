import 'package:coronaampel/data/dummy_data.dart';
import 'package:coronaampel/models/city.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var citys = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCitys();
  }

  void fetchCitys() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    var cityResults = DUMMY_CITYS;

    citys.assignAll(cityResults);
  }
}
