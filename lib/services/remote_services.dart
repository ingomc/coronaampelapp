import 'package:coronaampel/models/test_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Users>> fetchUsers() async {
    var response =
        await client.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return usersFromJson(jsonString);
    } else {
      // Error
      return null;
    }
  }
}
