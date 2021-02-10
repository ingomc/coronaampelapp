import 'package:coronampel/models/vaccine_model.dart';
import 'package:coronampel/services/vaccine_remote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetVaccineController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  ScrollController scrollController = new ScrollController();

  var dateUpdated =
      DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString().obs;
  var germany = Germany().obs;
  var states = [].obs;
  var lastUpdate = ''.obs;

  @override
  void onInit() {
    fetchVaccine();
    super.onInit();
  }

  Future<void> fetchVaccine() async {
    isLoading(true);
    print('triggered fetch vaccine');
    try {
      // DUMMY CONTNENT ----------------- //
      // await Future.delayed(
      //   Duration(milliseconds: 1000),
      // );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var vaccineResult = await RemoteServiceVaccine.fetchVaccine();

      states.assignAll(vaccineResult.states);
      germany.value = vaccineResult.germany;
      lastUpdate.value = vaccineResult.lastUpdate;
      dateUpdated.value =
          DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString();
    } catch (error) {
      print(error);
      throw Exception('Failed to load all states');
    } finally {
      isLoading(false);
      isRefreshIndicatorActive(false);
    }
  }
}
