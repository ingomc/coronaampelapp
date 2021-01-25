import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:coronaampel/data/dummy_data.dart';
import 'package:coronaampel/services/states_remote_service.dart';
import 'package:intl/intl.dart';

class GetStatesController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  ScrollController scrollController = new ScrollController();
  var dateUpdated =
      DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString().obs;
  var states = [].obs;
  var lastUpdate = ''.obs;

  @override
  void onInit() {
    fetchStates();
    super.onInit();
  }

  Future<void> fetchStates() async {
    isLoading(true);
    print('triggered fetch all states');
    try {
      // DUMMY CONTNENT ----------------- //
      await Future.delayed(
        Duration(milliseconds: 1000),
      );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var statesResult = await RemoteServiceStates.fetchAllStates();

      states.assignAll(statesResult.locations);
      lastUpdate.value = statesResult.lastUpdate;
      dateUpdated.value =
          DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString();
    } catch (error) {
      print(error);
      throw Exception('Failed to load all states');
    } finally {
      isLoading(false);
    }
  }
}
