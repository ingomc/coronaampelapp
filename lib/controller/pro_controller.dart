import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProController extends GetxController {
  var isPro = false.obs;
  var freeITS = false.obs;
  var freeVaccine = false.obs;
  final box = GetStorage();
  final devproNamespace = 'devpro';

  @override
  void onInit() async {
    var storedDevpro = box.read(devproNamespace);
    isPro.value = storedDevpro ?? false;

    ever(isPro, (_) {
      box.write(devproNamespace, isPro.value);
    });
    super.onInit();
  }
}
