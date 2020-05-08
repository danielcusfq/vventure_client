import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/common_models/basic_card.dart';

//this class communicates with the server and fetches a list of users with their basic information

class Communication {
  static Future<List<BasicCardInfo>> fetchResults(
      String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    String url =
        "https://vventure.tk/investor/favorites/results/?auth=ae620859b6016bcdde49fd9a8bcb932d720a863f51034fc9da6a4f21db39b2a5" +
            id +
            token;
    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    List<BasicCardInfo> users = new List();
    List<dynamic> rawData = new List();

    print(response.statusCode);
    print(response.body);

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
