import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/common_models/timeline.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';
import 'package:vventure/entrepreneur/main/common_models/profile.dart';

class Communication {
  static Future<Profile> fetchProfile(
      String investor, String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    investor = "&investor=" + investor;
    String url =
        "https://vventure.tk/entrepreneur/profile/investor/?auth=7651a608b416bbd74d24f75f7ece3fe50878cb08eb524f13086a01320fa2dabf" +
            id +
            token +
            investor;

    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    Profile profile;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      if (jsonData['res'].toString() == "success") {
        List<dynamic> rawData = new List();
        List<Highlight> highlights = new List();
        rawData = jsonData['highlights'];
        rawData.forEach((key) => highlights.add(new Highlight(
            key['id'].toString(),
            key['iduser'].toString(),
            key['description'].toString())));

        List<Info> info = new List();
        rawData = jsonData['info'];
        rawData.forEach((key) => info.add(new Info(
            key['id'].toString(),
            key['idperson'].toString(),
            key['title'].toString(),
            key['content'].toString(),
            key['pos'])));

        List<WorkImage> images = new List();
        rawData = jsonData['images'];
        rawData.forEach((key) => images.add(new WorkImage(key['id'].toString(),
            key['iduser'].toString(), key['image'].toString())));

        List<UserTimeline> timeline = new List();
        rawData = jsonData['timeline'];
        rawData.forEach((key) => timeline.add(new UserTimeline(
            key['id'].toString(),
            key['iduser'].toString(),
            key['detail'].toString(),
            key['position'])));

        bool inFavorites = jsonData['infavorites'];

        profile = new Profile(
            jsonData['name'].toString(),
            jsonData['last'].toString(),
            jsonData['organization'].toString(),
            jsonData['image'].toString(),
            jsonData['video'].toString(),
            jsonData['interests'].toString(),
            jsonData['background'].toString(),
            highlights,
            info,
            images,
            timeline,
            inFavorites);

        return profile;
      } else {
        return profile;
      }
    } else {
      return profile;
    }
  }

  static Future<String> requestInspection(
      String investor, String id, String token) async {
    Map data = {
      'auth':
          "54983ad0bc722a62d3072c5173ae7824b079eaa93cebb3c6425664f2210073d3",
      'investor': investor,
      'id': id,
      'token': token
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/inspection/request/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return "success";
      } else {
        return "fail";
      }
    } else {
      return "fail";
    }
  }
}
