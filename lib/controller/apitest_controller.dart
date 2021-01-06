import 'package:coronaampel/services/remote_services.dart';
import 'package:get/get.dart';

import 'city_list_controller.dart';

class ApitestController extends GetxController {
  var userList = [].obs;
  final cityListController = Get.put(CityListController());

  @override
  void onInit() {
    fetchUsers();
    super.onReady();
  }

  void fetchUsers([citys]) async {
    if (citys != null) {
      citys.forEach((city) => {print(city.name)});
    }
    var users = await RemoteServices.fetchUsers();
    if (users != null) {
      userList.assignAll(users);
    }
  }
}
