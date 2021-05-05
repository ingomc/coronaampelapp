// @dart=2.9
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronampel/models/states_model.dart';

class RemoteServiceStates {
  static var client = http.Client();

  static Future<States> fetchAllStates() async {
    Uri url =
        Uri.parse('https://ampeldata.andre-bellmann.de/states/index.json');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = statesFromJson(jsonString);
        return allData;
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre -App!',
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load all states');
      }
    } catch (error) {
      print('Error:');
      print(error);
      return error;
    }
  }
}
