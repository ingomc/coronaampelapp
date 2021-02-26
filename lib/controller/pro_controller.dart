import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProController extends GetxController {
  var isPro = false.obs;
  final box = GetStorage();
  final boxnamespace = 'pro';

  @override
  void onInit() {
    var storedPro = box.read(boxnamespace);
    if (storedPro != null) {
      isPro.value = storedPro;
    }
    ever(isPro, (_) {
      box.write(boxnamespace, isPro.value);
      Get.snackbar(
          isPro.value ? 'PRO wurde aktiviert! ✅' : 'Pro wurde deaktiviert ❌',
          isPro.value
              ? 'Alle Features sind freigeschalten, du musst keine Werbung mehr anschauen.'
              : 'Du hast die Standardapp mit Werbung.',
          snackPosition: SnackPosition.BOTTOM);
    });
    super.onInit();
  }
}
