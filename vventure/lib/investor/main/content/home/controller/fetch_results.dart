import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/common_models/basic_card.dart';

class FetchResults {
  static Future<List<BasicCardInfo>> fetchResults() async {
    final response = await http.get(
        "https://vventure.tk/investor/results/?auth=9275b806411f4d3f3285ba9022c798d7ca48ab704a8d09a1dc6752522cbe1c73");
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
