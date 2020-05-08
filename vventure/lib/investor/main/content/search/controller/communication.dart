import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/common_models/basic_card.dart';

//this class communicates with the user

class Communication {
  static Future<List<BasicCardInfo>> fetchResults(
      String id, String token, String query) async {
    id = "&id=" + id;
    token = "&token=" + token;
    query = "&query=" + query;
    String url =
        "https://vventure.tk/investor/search/?auth=0f049c3943613f61c699d434cbbd56817965cf3125ae8c012b4748fdb3044617" +
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
            key['stage'].toString(),
            key['image'].toString())));
      }
    }

    return users;
  }
}
