import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/common_models/highlight.dart';
import 'package:vventure/investor/main/common_models/info.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:vventure/investor/main/common_models/work_image.dart';
import 'package:vventure/investor/main/common_models/profile.dart';

class Communication {
  static Future<Profile> fetchProfile(
      String entrepreneur, String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    entrepreneur = "&entrepreneur=" + entrepreneur;
    String url =
        "https://vventure.tk/investor/profile/entrepreneur/?auth=cf91a3a228ad6ca9f12b8551050eddbe1e590ffa790275fead7d237cf99969cb" +
            id +
            token +
            entrepreneur;

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
            jsonData['stage'].toString(),
            jsonData['stake'].toString(),
            jsonData['stakeinfo'].toString(),
            jsonData['problem'].toString(),
            jsonData['solution'].toString(),
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
}
