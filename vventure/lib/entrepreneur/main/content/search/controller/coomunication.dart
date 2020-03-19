import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/basic_card.dart';

class Communication {
  static Future<List<BasicCardInfo>> fetchResults(
      String id, String token, String query) async {
    id = "&id=" + id;
    token = "&token=" + token;
    query = "&query=" + query;
    String url =
        "https://vventure.tk/entrepreneur/search/?auth=052dcfd3508f2f4dc59b02a77358a0e17fc07b10908cd10d681d24610437408f" +
            id +
            token +
            query;
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
