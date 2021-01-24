import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:coronaampel/models/global_model.dart';

class RemoteServiceGlobal {
  static var client = http.Client();

  static Future<Worldwide> fetchGlobal() async {
    String url = 'https://ingomc.github.io/corona-ampel-be/global/index.json';

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = worldwideFromJson(jsonString);
        return allData;
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre Corona-Ampel-App!',
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
