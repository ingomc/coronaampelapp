import 'package:coronaampel/models/test_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Citys> fetchUsers([citys]) async {
    if (citys != null && citys.length > 0) {
      // Make list map with all locationstrings
      var locations = [];
      citys.forEach((city) => {
            locations.add("county = '${city.county.toString().toUpperCase()}'")
          });

      // join all locations encode it
      String citysString = Uri.encodeFull(locations.join(' OR '));

      // Real url fetched from RKI
      // Cityname, incidences etc.
      String url =
          'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?outFields=COUNTY%2COBJECTID%2CGEN%2CBEZ%2CRS%2Ccases7_per_100k%2Clast_update&returnGeometry=false&f=json&outSR=4326&where=${citysString}';
      // print(url);

      try {
        var response = await client.get(url);
        if (response.statusCode == 200) {
          // Succesful fetch
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
      } catch (error) {
        print(error);
      }
    }
    // Snackbar, no Citys selected!
    Get.snackbar('Keine Landkreise ausgewählt',
        'Gehe auf die Startseite, Suche dort nach Landkreisen und füge diese deiner List hinzu!',
        snackPosition: SnackPosition.BOTTOM);
    return null;
  }
}
