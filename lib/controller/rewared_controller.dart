import 'package:get/get.dart';

class RewardedController extends GetxController {
  var isRewarded = false.obs;
  var isloaded = false.obs;
  var isError = false.obs;

  Future<void> waitingForError() async {
    await Future.delayed(
      Duration(milliseconds: 15000),
    );
    isError.value = true;
  }
}
