import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/common_models/timeline.dart';
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
            jsonData['stage'].toString(),
            jsonData['stake'].toString(),
            jsonData['stakeinfo'].toString(),
            jsonData['problem'].toString(),
            jsonData['solution'].toString(),
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
            "2d75b3c9f1a0986361022cc789546001ca5370224cda732e55aa18c3c0549867",
        'id': id,
        'token': token,
        'type': type,
        'video': video,
        'ext': ext
      };

      final response = await http.post(
          "https://vventure.tk/entrepreneur/profile/update/video/",
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
            "58c9f66f088872805a34ebbe24f971f80b6e914736d08a4fedcdcdfb743c3c9b",
        'id': id,
        'token': token,
        'type': type,
        'image': image,
        'ext': ext
      };
      final response = await http.post(
          "https://vventure.tk/entrepreneur/profile/update/profile_image/",
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
          "13496a7b21b744a01b08da955937251cff3e1cdac7189b485138a87d471aa3db",
      'id': id,
      'token': token,
      'type': type,
      'organization': organization
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/organization/",
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
          "927301fc7588331163dbe11c8168b2af9a92e46e5b3f339a8e06ce7c3daaa428",
      'id': id,
      'token': token,
      'type': type,
      'name': name,
      'last': lastName
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/name/",
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
  //-------------------Stage----------------------------------------------------
  static Future<bool> updateStage(
      String id, String token, String type, String stage) async {
    Map data = {
      'auth':
          "16a90b81f4004bd627fd4462dd0416be5c00b243ecb4267c8bf9a0e1b70060a8",
      'id': id,
      'token': token,
      'type': type,
      'stage': stage
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/stage/",
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
  //-------------------Stake----------------------------------------------------
  static Future<bool> updateStake(String id, String token, String type,
      String stake, String exchange) async {
    Map data = {
      'auth':
          "ffe94004943ede695970aa04170a359cfc6f193a7212d105385aa6bb4ea98cbc",
      'id': id,
      'token': token,
      'type': type,
      'stake': stake,
      'exchange': exchange
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/stake/",
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
  //-------------------Problem--------------------------------------------------
  static Future<bool> updateProblem(
      String id, String token, String type, String problem) async {
    Map data = {
      'auth':
          "424e36889a5fdde2549a5153410ccea88ea9aeee4955e26f57b7629966650a3c",
      'id': id,
      'token': token,
      'type': type,
      'problem': problem
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/problem/",
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
  //-------------------Solution-------------------------------------------------
  static Future<bool> updateSolution(
      String id, String token, String type, String solution) async {
    Map data = {
      'auth':
          "8f2a413f76baa5cd42de059398b467ecc81675f23707060f9498e50bdfebaff6",
      'id': id,
      'token': token,
      'type': type,
      'solution': solution
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/solution/",
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
      String id, String token, File imageFile, String type) async {
    String image;
    String ext;

    if (imageFile != null) {
      image = base64Encode(imageFile.readAsBytesSync());
      ext = imageFile.path.split('.').last;

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

  //----------------------------------------------------------------------------
  //-------------------Timeline-------------------------------------------------
  static Future<bool> insertTimeline(
      String id, String token, String type, String detail) async {
    Map data = {
      'auth':
          "6a391198f489808f558534e9076fa893a204bd622e8c6ce9f25133b934e4bb6f",
      'id': id,
      'token': token,
      'type': type,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/insert/timeline/",
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
          "7a3defcec07e39d2a163bb0276b33e6fae6d0911415412efd25d812c23ad78ea",
      'id': id,
      'token': token,
      'type': type,
      'id_timeline': idTimeline,
      'detail': detail
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/update/timeline/",
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
          'f3952cde77f55eff87419f14a2f1680d8553b75d0850f0d64f138613d650b131',
      'id': id,
      'token': token,
      'type': type,
      'id_timeline': idTimeline
    };
    final response = await http.post(
        "https://vventure.tk/entrepreneur/profile/delete/timeline/",
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
