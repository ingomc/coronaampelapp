import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PinnedCountysController extends GetxController {
  var countys = [].obs;
  final box = GetStorage();

  @override
  void onInit() {
    print(box.read('countys'));
    var storedCountys = box.read('countys');
    countys.assignAll(storedCountys ??= []);
    ever(countys, (_) {
      box.write('countys', countys.toSet().toList());
    });
    super.onInit();
  }

  toggleCounty(int index) {
    countys.contains(index) ? countys.remove(index) : countys.add(index);
  }
}
