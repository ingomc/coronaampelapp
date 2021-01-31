import 'package:coronaampel/models/gps_location_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RemoteServiceLocation {
  static var client = http.Client();

  static Future<String> fetchLocationCounty(
      String longitude, String lattitude) async {
    String url =
        'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=GEN&geometry=$longitude%2C$lattitude&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json';

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // Succesful fetch
        var jsonString = response.body;
        var allData = gpsLocationFromJson(jsonString);
        return allData.features[0].attributes.gen.toString();
      } else {
        // If that call was not successful, throw an error.
        // Error
        Get.snackbar("Fehler!",
            'Ihre Position wurde nicht gefunden. Es ist ein Fehler aufgetretet. Versuchen sie es später erneut.',
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load position from RKI');
      }
    } catch (error) {
      print('Error:');
      print(error);
      return error;
    }
  }
}
