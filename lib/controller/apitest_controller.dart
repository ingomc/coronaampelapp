import 'package:coronaampel/models/test_model.dart';
import 'package:coronaampel/services/remote_services.dart';
import 'package:get/get.dart';

import 'city_list_controller.dart';

class ApitestController extends GetxController {
  var isLoading = false.obs;
  var userList = [].obs;
  final cityListController = Get.put(CityListController());

  // @override
  // void onInit() {
  //   fetchUsers();
  //   super.onReady();
  // }

  void fetchUsers([citys]) async {
    isLoading(true);
    await Future.delayed(
      Duration(seconds: 1),
    );
    try {
      var users = await RemoteServices.fetchUsers(citys);
      if (users != null) {
        // print(users);
        userList.assignAll(users.features);
        // userList.value = users;
      } else {
        // Fehler oder keine Daten, wird im service gesnacked
        userList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }
  }
}
