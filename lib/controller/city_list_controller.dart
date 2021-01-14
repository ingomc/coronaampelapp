import 'package:coronaampel/models/city.dart';
import 'package:coronaampel/models/test_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'apitest_controller.dart';

class CityListController extends GetxController {
  final ApitestController apitestController = Get.put(ApitestController());
  final box = GetStorage('citys');
  // get storedCitys => box.read('citys') ?? [];
  var citys = [].obs;

  @override
  void onInit() {
    print('Init:    ------');
    print(box.read('citys'));
    box.listen(() async {
      var storedCitys = box.read('citys') ?? [];
      citys.assignAll(storedCitys);
      // if (storedCitys.sort() == citys.generate().sort()) {}
      await apitestController.fetchUsers(citys);
    });

    super.onInit();
  }

  saveCityList(List<dynamic> newCityList) {
    box.write('citys', newCityList);
  }

  instantRemoveCity(index) {
    citys.removeAt(index);
    box.write('citys', citys.toList());
  }

  toggleCityToList(String county) {
    String cityInList =
        citys.firstWhere((cityItem) => cityItem == county, orElse: () => null);

    List<String> _tempCitys = [...citys.toList()];

    if (cityInList == null) {
      _tempCitys.add(county);
    } else {
      _tempCitys.remove(county);
    }
    box.write('citys', _tempCitys);
    print('saved');
    print(box.read('citys'));
  }
}
