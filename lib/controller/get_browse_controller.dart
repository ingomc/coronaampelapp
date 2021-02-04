import 'package:coronaampel/models/browse_model.dart';
import 'package:coronaampel/services/browse_remote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetBrowseController extends GetxController {
  var isLoading = false.obs;
  var isRefreshIndicatorActive = false.obs;
  ScrollController scrollController = new ScrollController();
  var dateUpdated =
      DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString().obs;
  // var data = Map<Browse>.obs;
  var highest5 = [].obs;
  var lowest5 = [].obs;
  var highest5CasesPer100K = [].obs;
  var highest5Ewz = [].obs;

  @override
  void onInit() {
    fetchBrowse();
    super.onInit();
  }

  Future<void> fetchBrowse() async {
    isLoading(true);
    print('triggered fetch vaccine');
    try {
      // DUMMY CONTNENT ----------------- //
      await Future.delayed(
        Duration(milliseconds: 1000),
      );
      // var cityResults = DUMMY_CITYS.locations;
      // schau im todo beispiel nach wie das geht

      var browseResult = await RemoteServiceBrowse.fetchBrowse();

      // data.value = browseResult;
      highest5.assignAll(browseResult.highest5);
      lowest5.assignAll(browseResult.lowest5);
      highest5CasesPer100K.assignAll(browseResult.highest5CasesPer100K);
      highest5Ewz.assignAll(browseResult.highest5Ewz);

      dateUpdated.value =
          DateFormat('dd.MM., HH:mm').format(DateTime.now()).toString();
    } catch (error) {
      print(error);
      throw Exception('Failed to load all browsedata');
    } finally {
      isLoading(false);
      isRefreshIndicatorActive(false);
    }
  }
}
