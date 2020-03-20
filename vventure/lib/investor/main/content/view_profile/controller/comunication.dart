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

  static Future<String> requestContactInformation(
      String id, String token, String entrepreneur) async {
    id = "&id=" + id;
    token = "&token=" + token;
    entrepreneur = "&entrepreneur=" + entrepreneur;
    String url =
        "https://vventure.tk/investor/contact/?auth=357c4b87c630bd41efc01097ff535209d1eba8bc536964902cf4e1653596ebbf" +
            id +
            token +
            entrepreneur;

    final response = await http.get(url);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      if (jsonData['res'].toString() == "success") {
        return "succes";
      } else {
        return "fail";
      }
    } else {
      return "fail";
    }
  }

  static Future<String> addToFavorites(
      String id, String token, String entrepreneur) async {
    Map data = {
      'auth':
          "62a9addde6deec5dc3e747a592649ddc40dc3077823d8d8fae2c10b3d97a36b3",
      'entrepreneur': entrepreneur,
      'id': id,
      'token': token
    };
    final response = await http
        .post("https://vventure.tk/investor/favorites/add/", body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        return "success";
      } else {
        return "fail";
      }
    } else {
      return "fail";
    }
  }

  static Future<String> removeFromFavorites(
      String id, String token, String entrepreneur) async {
    Map data = {
      'auth':
          "7ec53e6efe4bee1bcba65122e6e67f38c8224658b3f86c8681df5fe77d33b3c2",
      'entrepreneur': entrepreneur,
      'id': id,
      'token': token
    };
    final response = await http
        .post("https://vventure.tk/investor/favorites/remove/", body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        return "success";
      } else {
        return "fail";
      }
    } else {
      return "fail";
    }
  }
}
