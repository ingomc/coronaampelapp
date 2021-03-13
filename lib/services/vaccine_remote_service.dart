import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronampel/models/vaccine_model.dart';

class RemoteServiceVaccine {
  static var client = http.Client();

  static Future<Vaccine> fetchVaccine() async {
    String url = 'https://ampeldata.andre-bellmann.de/vaccine/index.json';

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = vaccineFromJson(jsonString);
        return allData;
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre -App!',
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load vaccine');
      }
    } catch (error) {
      print('Error:');
      print(error);
      return error;
    }
  }
}
