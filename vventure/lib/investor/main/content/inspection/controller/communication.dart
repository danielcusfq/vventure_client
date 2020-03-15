import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/content/inspection/model/inspection_model.dart';
import 'package:vventure/investor/main/common_models/basic_card.dart';

class Communication {
  static Future<List<BasicCardInfo>> fetchUsers(String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    String url =
        "https://vventure.tk/investor/inspection/users/?auth=355155b15b8f4acab45ac8cb623522b5c60d82a300429e3723c84853f6633ded" +
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
        rawData.forEach((key) => users.add(new BasicCardInfo.inspection(
            key['id'].toString(),
            key['organization'].toString(),
            key['stage'].toString(),
            key['image'].toString(),
            key['inspection'].toString())));
      }
    }

    return users;
  }

  static Future<InspectionModel> fetchInspection(
      String id, String token, String inspection) async {
    id = "&id=" + id;
    token = "&token=" + token;
    inspection = "&inspection=" + inspection;
    String url =
        "https://vventure.tk/investor/inspection/detail/?auth=cb7ee1818d60a7f8888a9c3d2125e9cf8a04ac5a417f6487a355caed5cac360a" +
            id +
            token +
            inspection;

    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    InspectionModel inspectionData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        inspectionData = new InspectionModel(
            jsonData['image'].toString(),
            jsonData['organization'].toString(),
            jsonData['name'].toString(),
            jsonData['last'].toString(),
            jsonData['detail'].toString());
      }
    }

    return inspectionData;
  }

  static Future<List<BasicCardInfo>> fetchInspectionHistory(
      String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    String url =
        "https://vventure.tk/investor/inspection/history/?auth=6d0210379efe392a654aa989d4ac1cfe4d4f1719e1906f695c302926b7c296e6" +
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
        rawData.forEach((key) => users.add(new BasicCardInfo.inspection(
            key['id'].toString(),
            key['organization'].toString(),
            key['stage'].toString(),
            key['image'].toString(),
            key['inspection'].toString())));
      }
    }

    return users;
  }

  static Future<String> denyInspection(
      String inspection, String entrepreneur, String id, String token) async {
    Map data = {
      'auth':
          "8916c77882b8dd2ca9ceccf58c275a26b975d3bb47269376312e41569c47430e",
      'inspection': inspection,
      'entrepreneur': entrepreneur,
      'id': id,
      'token': token
    };

    final response = await http
        .post("https://vventure.tk/investor/inspection/deny/", body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      if (jsonData['res'].toString() == "success") {
        return "success";
      } else {
        return "error";
      }
    } else {
      return "error";
    }
  }

  static Future<String> giveFeedback(String inspection, String entrepreneur,
      String id, String token, String description) async {
    Map data = {
      'auth':
          "e2c1466c3f0d308de5c0aabf430b3f6ee24c5c9c28d3a51018dc5bdbd06af70a",
      'inspection': inspection,
      'entrepreneur': entrepreneur,
      'id': id,
      'token': token,
      'description': description
    };

    final response = await http
        .post("https://vventure.tk/investor/inspection/feedback/", body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      if (jsonData['res'].toString() == "success") {
        return "success";
      } else {
        return "error";
      }
    } else {
      return "error";
    }
  }
}
