import 'package:coronaampel/services/remote_services.dart';
import 'package:get/get.dart';

class ApitestController extends GetxController {
  var userList = [].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onReady();
  }

  void fetchUsers() async {
    var users = await RemoteServices.fetchUsers();
    if (users != null) {
      userList.assignAll(users);
    }
  }
}
