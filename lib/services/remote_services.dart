import 'package:coronaampel/models/test_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Citys> fetchUsers([citys]) async {
    if (citys != null) {
      citys.forEach((city) => {print(city.county)});

      var locations = [];
      citys.forEach((city) => {locations.add('county = %27${city.county}%27')});
      print(locations.join());
    }

    String url =
        'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?outFields=OBJECTID%2CGEN%2CBEZ%2CRS%2Ccases7_bl_per_100k%2Clast_update&returnGeometry=false&f=json&outSR=4326&where=county%20=%20%27SK%20COBURG%27%20OR%20county%20=%20%27LK%20RH%C3%96N-GRABFELD%27';
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var allData = citysFromJson(jsonString);
      return allData;
    } else {
      // Error
      return null;
    }
  }
}
