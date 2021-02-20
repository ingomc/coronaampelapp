import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:coronampel/data/dummy_data.dart';
import 'package:coronampel/services/countys_remote_service.dart';
import 'package:intl/intl.dart';

class GetCountysController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  ScrollController scrollController = new ScrollController();
  var dateUpdated =
      DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString().obs;
  var countys = [].obs;
  var lastUpdate = ''.obs;

  Future<void> fetchCountys() async {
    isLoading(true);
    print('triggered fetch all countys');
    try {
      // DUMMY CONTNENT ----------------- //
      // await Future.delayed(
      //   Duration(milliseconds: 2000),
      // );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var countysResult = await RemoteServiceCountys.fetchAllCountys();

      countys.assignAll(countysResult.locations);
      lastUpdate.value = countysResult.date;
      dateUpdated.value =
          DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString();
    } catch (error) {
      print(error);
      throw Exception('Failed to load all countys');
    } finally {
      isLoading(false);
      isRefreshIndicatorActive(false);
    }
  }
}
