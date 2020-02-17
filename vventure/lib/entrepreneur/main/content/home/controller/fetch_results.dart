import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/basic_card.dart';

class FetchResults {
  static Future<List<BasicCardInfo>> fetchResults() async {
    final response = await http.get(
        "https://vventure.tk/entrepreneur/results/?auth=80d3d6348cf687df8c7fbd7dc901822f594a27e22a97e7ae10db253d3d3da684");
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
