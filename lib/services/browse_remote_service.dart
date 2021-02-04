import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronaampel/models/browse_model.dart';

class RemoteServiceBrowse {
  static var client = http.Client();

  static Future<Browse> fetchBrowse() async {
    String url = 'https://ingomc.github.io/corona-ampel-be/browse/index.json';

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = browseFromJson(jsonString);
        return allData;
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre Corona-Ampel-App!',
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load browsedata');
      }
    } catch (error) {
      print('Error:');
      print(error);
      return error;
    }
  }
}