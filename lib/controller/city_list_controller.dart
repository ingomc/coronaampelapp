import 'package:coronaampel/models/city.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CityListController extends GetxController {
  final box = GetStorage('citys');
  var citys = [].obs;

  @override
  void onInit() {
    // box.listen(() {
    //   var storedCitys = box.read('citys') ?? [];
    //   if (storedCitys.length > 0) {
    //     citys.assignAll(storedCitys);
    //   }
    // });

    super.onInit();
  }

  toggleCityToList(String county) {
    String cityInList =
        citys.firstWhere((cityItem) => cityItem == county, orElse: () => null);

    if (cityInList == null) {
      citys.add(county);
    } else {
      citys.remove(county);
    }
    box.write('citys', citys);
  }
}
