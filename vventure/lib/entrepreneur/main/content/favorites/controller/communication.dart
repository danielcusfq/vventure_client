import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/basic_card.dart';

class Communication {
  static Future<List<BasicCardInfo>> fetchResults(
      String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    String url =
        "https://vventure.tk/entrepreneur/favorites/results/?auth=98266603212edabf6e53e3b485924814f3df41eb38aec6edbe2f2feb5e5767d3" +
            id +
            token;
    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    List<BasicCardInfo> users = new List();
    List<dynamic> rawData = new List();

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        rawData = jsonData['users'];
        rawData.forEach((key) => users.add(new BasicCardInfo(
            key['id'].toString(),
            key['organization'].toString(),
            key['name'].toString(),
            key['last'].toString(),
            key['image'].toString())));
      }
    }

    return users;
  }
}
