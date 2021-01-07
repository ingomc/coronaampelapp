import 'package:coronaampel/models/test_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Citys> fetchUsers([citys]) async {
    if (citys != null && citys.length > 0) {
      citys.forEach((city) => {print(city.county)});

      var locations = [];
      citys.forEach((city) => {
            locations.add("county = '${city.county.toString().toUpperCase()}'")
          });
      print(Uri.encodeFull(locations.join(' OR ')));
      String citysString = Uri.encodeFull(locations.join(' OR '));

      String url =
          'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?outFields=OBJECTID%2CGEN%2CBEZ%2CRS%2Ccases7_per_100k%2Clast_update&returnGeometry=false&f=json&outSR=4326&where=${citysString}';
      print(url);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var allData = citysFromJson(jsonString);
        return allData;
      } else {
        // Error
        Get.snackbar("Fehler!",
            'Ein Fehler ist aufgetreten, versuchen sie es später noch einmal, oder updaten sie ihre Corona-Ampel-App!',
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    }
    // Snackbar, no Citys selected!
    // Snackbar
    Get.snackbar('Keine Landkreise ausgewählt',
        'Gehe auf die Startseite, Suche dort nach Landkreisen und füge diese deiner List hinzu!',
        snackPosition: SnackPosition.BOTTOM);
    return null;
  }
}
