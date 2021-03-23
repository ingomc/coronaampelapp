import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronampel/models/countys_model.dart';

class RemoteServiceCountys {
  static var client = http.Client();

  static Future<Countys> fetchAllCountys() async {
    Uri url =
        Uri.parse('https://ampeldata.andre-bellmann.de/countys/index.json');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = countysFromJson(jsonString);
        return allData;
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre -App!',
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load all countys');
      }
    } catch (error) {
      print('Error:');
      print(error);
      return error;
    }
  }
}
