import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/content/profile/model/my_profile.dart';

class Communication {
  static Future<MyProfile> fetchProfile(String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;

    String url =
        "https://vventure.tk/entrepreneur/profile/info/?auth=ee046aa3e8cba86d08f5c902c2dba507c7ec6c63da3cbc0262ff2e5d3f969854" +
            id +
            token;
    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    MyProfile profile;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      if (jsonData['res'].toString() == "success") {
        profile = new MyProfile(
            jsonData['name'].toString(),
            jsonData['last'].toString(),
            jsonData['organization'].toString(),
            jsonData['image'].toString(),
            jsonData['video'].toString(),
            jsonData['stage'].toString(),
            jsonData['stake'].toString(),
            jsonData['stakeinfo'].toString(),
            jsonData['problem'].toString(),
            jsonData['solution'].toString(),
            null,
            null,
            null,
            null);
      }
    } else {
      print("no success");
    }

    return profile;
  }
}
