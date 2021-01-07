import 'package:coronaampel/models/test_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Citys> fetchUsers() async {
    var response = await client.get(
        'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?outFields=OBJECTID%2CGEN%2CBEZ%2CRS%2Ccases7_bl_per_100k%2Clast_update&returnGeometry=false&f=json&outSR=4326&where=county%20=%20%27SK%20COBURG%27');
    // var response = await client.get('https://jsonplaceholder.typicode.com/users');

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
