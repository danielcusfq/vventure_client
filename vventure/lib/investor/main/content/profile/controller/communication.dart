import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vventure/investor/main/common_models/highlight.dart';
import 'package:vventure/investor/main/common_models/info.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:vventure/investor/main/common_models/work_image.dart';
import 'package:vventure/investor/main/content/profile/model/my_profile.dart';

class Communication {
  static Future<MyProfile> fetchProfile(String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;

    String url =
        "https://vventure.tk/investor/profile/info/basic/?auth=dbfc41327aa4e3658bc31596579209cadf6566cffcb754645b818bc88ba4ec19" +
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

        List<UserTimeline> timeline = new List();
        rawData = jsonData['timeline'];
        rawData.forEach((key) => timeline.add(new UserTimeline(
            key['id'].toString(),
            key['iduser'].toString(),
            key['detail'].toString(),
            key['position'])));

        profile = new MyProfile(
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
            timeline);
      }
    }

    return profile;
  }

  //----------------------------------------------------------------------------
  //-------------------Profile Video--------------------------------------------
  static Future<bool> insertVideo(
      String id, String token, File videoFile, String type) async {
    String video;
    String ext;

    if (videoFile != null) {
      video = base64Encode(videoFile.readAsBytesSync());
      ext = videoFile.path.split('.').last;

      Map data = {
        'auth':
            "11b1bb7929b3348c1dc0ee17dc20b8166a868d67bacb7181b50890d05320b968",
        'id': id,
        'token': token,
        'type': type,
        'video': video,
        'ext': ext
      };

      final response = await http.post(
          "https://vventure.tk/investor/profile/update/video/",
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
    } else {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  //-------------------Profile Image--------------------------------------------
  static Future<bool> insertProfileImage(
      String id, String token, File imageFile, String type) async {
    String image;
    String ext;

    if (imageFile != null) {
      image = base64Encode(imageFile.readAsBytesSync());
      ext = imageFile.path.split('.').last;

      Map data = {
        'auth':
            "7892cabe8bba72b69adbfe32c139e1b214360af7d649cb2a900ebe8e6523c328",
        'id': id,
        'token': token,
        'type': type,
        'image': image,
        'ext': ext
      };
      final response = await http.post(
          "https://vventure.tk/investor/profile/update/profile_image/",
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
    } else {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  //-------------------Organization---------------------------------------------
  static Future<bool> updateOrganization(
      String id, String token, String organization, String type) async {
    Map data = {
      'auth':
          "50b5bea6375fb5565e5cfa42f01c91cce1ee099a604c2fac353c820048e055d2",
      'id': id,
      'token': token,
      'type': type,
      'organization': organization
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/update/organization/",
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
  //-------------------Name-----------------------------------------------------
  static Future<bool> updateName(String id, String token, String type,
      String name, String lastName) async {
    Map data = {
      'auth':
          "b617206d3646e21a68156e88de0938a672a52219b76c14baec72869e889db110",
      'id': id,
      'token': token,
      'type': type,
      'name': name,
      'last': lastName
    };
    final response = await http
        .post("https://vventure.tk/investor/profile/update/name/", body: data);
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
  //-------------------Interests------------------------------------------------
  static Future<bool> updateInterests(
      String id, String token, String type, String interest) async {
    Map data = {
      'auth':
          "29e5fa9c1528a0f6d5cc51b79a619873f2cb95c4e41b7490d028184924583022",
      'id': id,
      'token': token,
      'type': type,
      'interest': interest
    };

    final response = await http.post(
        "https://vventure.tk/investor/profile/update/interests/",
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
  //-------------------Background-----------------------------------------------
  static Future<bool> updateBackground(
      String id, String token, String type, String background) async {
    Map data = {
      'auth':
          "85e11a30110d8687f39caa7eef251a929bee3415ee4923d3f93697b986dab799",
      'id': id,
      'token': token,
      'type': type,
      'background': background
    };

    final response = await http.post(
        "https://vventure.tk/investor/profile/update/background/",
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
  //-------------------HIGHLIGHTS-----------------------------------------------
  static Future<bool> insertHighlight(
      String id, String token, String detail, String type) async {
    Map data = {
      'auth':
          "13f4667e8740a0fccc7680b42b43bf89525aebf33b59343e279d36f61e5e96ea",
      'id': id,
      'token': token,
      'type': type,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/insert/highlight/",
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
          "5607ad722c4a315ed035cb0c7a8bea027c4090270c270ff5ab00ef1ab82c3f11",
      'id': id,
      'token': token,
      'type': type,
      'id_highlight': idHighlight,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/update/highlight/",
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
          'c563b7856ac22839f792721ac02d294c633fe9544e7081e727242b830d58fe6b',
      'id': id,
      'token': token,
      'type': type,
      'id_highlight': idHighlight
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/delete/highlight/",
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
          "ac4e7d80123eb6f32ce658fd967703539809265657db8b766855e13e31feb4fc",
      'id': id,
      'token': token,
      'type': type,
      'title': title,
      'detail': detail
    };
    final response = await http
        .post("https://vventure.tk/investor/profile/insert/info/", body: data);
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
          "8212fd0968904f4af1655909e85fe0feb7e314c55ad38d111e5ee7366bc95d96",
      'id': id,
      'token': token,
      'type': type,
      'id_info': idInfo,
      'title': title,
      'detail': detail
    };
    final response = await http
        .post("https://vventure.tk/investor/profile/update/info/", body: data);
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
          'd3a068303bab39c65720afed00c62e8a58fbb72f9c499cda7322e1462475825b',
      'id': id,
      'token': token,
      'type': type,
      'id_info': idInfo
    };
    final response = await http
        .post("https://vventure.tk/investor/profile/delete/info/", body: data);
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
      String id, String token, File imageFile, String type) async {
    String image;
    String ext;

    if (imageFile != null) {
      image = base64Encode(imageFile.readAsBytesSync());
      ext = imageFile.path.split('.').last;

      Map data = {
        'auth':
            "c0cdcf6c5d22053916a5efcdcb23fae308212585740a758088f10be4e2df2808",
        'id': id,
        'token': token,
        'type': type,
        'image': image,
        'ext': ext
      };
      final response = await http.post(
          "https://vventure.tk/investor/profile/insert/image/",
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
    } else {
      return false;
    }
  }

  static Future<bool> deleteImage(
      String id, String token, String type, String idImage) async {
    Map data = {
      'auth':
          '08afd9c6759ef1f08f9a03cfb23bc8d1e0b6b7f6faf4012342f7fe22ad815dd9',
      'id': id,
      'token': token,
      'type': type,
      'id_image': idImage
    };
    final response = await http
        .post("https://vventure.tk/investor/profile/delete/image/", body: data);
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
  //-------------------Timeline-------------------------------------------------
  static Future<bool> insertTimeline(
      String id, String token, String type, String detail) async {
    Map data = {
      'auth':
          "9d529201df14dbcbca856cbee54afc25e0f2ac6ef2987f01da555ec25e81b3a3",
      'id': id,
      'token': token,
      'type': type,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/insert/timeline/",
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

  static Future<bool> updateTimeline(String id, String token, String type,
      String idTimeline, String detail) async {
    Map data = {
      'auth':
          "2a89e1cc5e78242cc41fcf861a2ec69563779adf1cf4ea972826111747326413",
      'id': id,
      'token': token,
      'type': type,
      'id_timeline': idTimeline,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/update/timeline/",
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

  static Future<bool> deleteTimeline(
      String id, String token, String type, String idTimeline) async {
    Map data = {
      'auth':
          '93635062c7236dfd307a91bbb199055d2c200dae922e8a7f63d3e096781819ed',
      'id': id,
      'token': token,
      'type': type,
      'id_timeline': idTimeline
    };
    final response = await http.post(
        "https://vventure.tk/investor/profile/delete/timeline/",
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
