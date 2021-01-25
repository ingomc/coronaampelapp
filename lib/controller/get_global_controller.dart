import 'package:coronaampel/models/global_model.dart';
import 'package:coronaampel/services/global_remote_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetGlobalController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  var dateUpdated =
      DateFormat('dd.MM., kk:mm').format(DateTime.now()).toString().obs;
  var data = Worldwide().obs;

  void onInit() {
    fetchGlobalData();
    super.onInit();
  }

  Future<void> fetchGlobalData() async {
    isLoading(true);
    print('triggered fetch global');
    try {
      // DUMMY CONTNENT ----------------- //
      await Future.delayed(
        Duration(milliseconds: 1000),
      );

      var globalResult = await RemoteServiceGlobal.fetchGlobal();
      data.value = globalResult;
      dateUpdated.value =
          DateFormat('dd.MM., kk:mm').format(DateTime.now()).toString();
    } catch (error) {
      print(error);
      throw Exception('Failed to load all countys');
    } finally {
      isLoading(false);
    }
  }
}
