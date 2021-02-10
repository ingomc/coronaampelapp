import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronampel/models/county_model.dart';

class RemoteServiceCounty {
  static var client = http.Client();

  static Future<County> fetchAllCounty(rs) async {
    String url = 'https://ingomc.github.io/corona-ampel-be/county/$rs.json';

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = countyFromJson(jsonString);
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
