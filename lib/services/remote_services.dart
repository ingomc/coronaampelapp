import 'package:coronaampel/models/test_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<CitysData>> fetchUsers() async {
    var response = await client.get(
        'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?outFields=death7_bl%2Ccases7_bl_per_100k&returnGeometry=false&f=json&outSR=4326&where=county%20=%20%27SK%20COBURG%27');
    // var response = await client.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200) {
      print('res200');
      var jsonString = response.body;
      var split = jsonString.split('features":');
      var newJsonString = split[1].substring(0, split[1].length - 1);
      // print(split[1].substring(0, split[1].length - 1));
      var allData = citysDataFromJson(newJsonString);
      return allData;
    } else {
      // Error
      return null;
    }
  }
}
