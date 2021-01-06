import 'package:coronaampel/models/city.dart';
import 'package:get/get.dart';

class CityListController extends GetxController {
  var citys = [].obs;

  toggleCityToList(City city) {
    City cityInList = citys.firstWhere((cityItem) => cityItem.id == city.id,
        orElse: () => null);

    if (cityInList == null) {
      citys.add(city);
    } else {
      citys.remove(cityInList);
    }
  }
}
