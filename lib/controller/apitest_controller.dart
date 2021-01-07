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
    var users = await RemoteServices.fetchUsers(citys);
    if (users != null) {
      // print(users);
      userList.assignAll(users.features);
      // userList.value = users;
    } else {
      // Fehler oder keine Daten
      // Snackbar
      userList.assignAll([]);
    }
  }
}
