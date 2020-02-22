import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';
import 'package:vventure/entrepreneur/main/content/profile/model/my_profile.dart';

class Communication {
  static Future<MyProfile> fetchProfile(String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;

    String url =
        "https://vventure.tk/entrepreneur/profile/info/basic/?auth=ee046aa3e8cba86d08f5c902c2dba507c7ec6c63da3cbc0262ff2e5d3f969854" +
            id +
            token;
    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    MyProfile profile;

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
            highlights,
            info,
            images,
            null);
      }
    }

    return profile;
  }

  //----------------------------------------------------------------------------
  //-------------------HIGHLIGHTS-----------------------------------------------
  static Future<bool> insertHighlight(
      String id, String token, String detail, String type) async {
    Map data = {
      'auth':
          "f525ddc20d143230a7e3a2b4d6871ebf0bcbcc71816de9ae358ed6025a6f665f",
      'id': id,
      'token': token,
      'type': type,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/insert/highlight/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> updateHighlight(String id, String token, String detail,
      String type, String idHighlight) async {
    Map data = {
      'auth':
          "5a4517b3a15a2fc8961e5aeb63af6663f0cdcd9c1e48183dd67e57f6d7fb3728",
      'id': id,
      'token': token,
      'type': type,
      'id_highlight': idHighlight,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/highlight/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> deleteHighlight(
      String id, String token, String type, String idHighlight) async {
    Map data = {
      'auth':
          '2b7b9f856c3ce030f7545c3489b31c0687674208512e113a5d93a48cba0503db',
      'id': id,
      'token': token,
      'type': type,
      'id_highlight': idHighlight
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/delete/highlight/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  //-------------------Info-----------------------------------------------------
  static Future<bool> insertInfo(
      String id, String token, String title, String detail, String type) async {
    Map data = {
      'auth':
          "6523cde886413d7237021657b6fee69873e30376c4dbbb72ebf114f506d423d9",
      'id': id,
      'token': token,
      'type': type,
      'title': title,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/insert/info/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> updateInfo(String id, String token, String title,
      String detail, String type, String idInfo) async {
    Map data = {
      'auth':
          "2a9f190211c1eebc8280b7e9b77f3f7b2f806d8f64f06fba81730ba455ecb7f6",
      'id': id,
      'token': token,
      'type': type,
      'id_info': idInfo,
      'title': title,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/info/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> deleteInfo(
      String id, String token, String type, String idInfo) async {
    Map data = {
      'auth':
          '3542f67fa25e703491846af21cbf09007879f6f056427e36737ea33937ec6395',
      'id': id,
      'token': token,
      'type': type,
      'id_info': idInfo
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/delete/info/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  //------------------Image-----------------------------------------------------
  static Future<bool> insertImage(
      String id, String token, String image, String ext, String type) async {
    Map data = {
      'auth':
          "ed317b354577d279ac35f26dffac916169b83ff197f5f333b28a4c099a5ab5d7",
      'id': id,
      'token': token,
      'type': type,
      'image': image,
      'ext': ext
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/insert/image/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> deleteImage(
      String id, String token, String type, String idImage) async {
    Map data = {
      'auth':
          'eb432260e66deef8a6482ae9cebf98f5faabbcc0f19ce08b5edeb1bbdd043457',
      'id': id,
      'token': token,
      'type': type,
      'id_image': idImage
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/delete/image/",
        body: data);
    Map<String, dynamic> jsonData;

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        Timer(Duration(seconds: 2), () {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
