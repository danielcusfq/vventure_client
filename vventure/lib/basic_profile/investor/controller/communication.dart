import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/auth/info.dart';

class Communication {
  // completes registration of entrepreneur user
  static Future<String> completeRegister(
      UserInfo userInfo, File image, String interest, String background) async {
    String _base64image;
    String _ext;
    String _interest;
    String _background;
    Map _data;

    if (userInfo.activation == "1") {
      return "Activated";
    }

    if (image != null) {
      _base64image = base64Encode(image.readAsBytesSync());
      _ext = image.path.split('.').last;
    } else {
      _base64image = "";
      _ext = "";
    }

    if (interest.isNotEmpty) {
      _interest = interest;
    } else {
      _interest = "";
    }

    if (background.isNotEmpty) {
      _background = background;
    } else {
      _background = "";
    }

    _data = {
      "auth":
          "a5d2f6ffbaeb6e229e05e0b2e6a9136473778c0160d3a4d07f4c380067b3c2cd",
      "token": userInfo.token,
      "type": userInfo.type,
      "image": _base64image,
      "ext": _ext,
      "interests": _interest,
      "background": _background
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http
        .post("https://vventure.tk/complete_register/investor/", body: _data);
    Map<String, dynamic> jasonData;

    if (response.statusCode == 200) {
      jasonData = json.decode(response.body);

      if (jasonData['res'].toString() == "success" &&
          jasonData['type'].toString() == "2" &&
          jasonData['activation'].toString() == "1") {
        sharedPreferences.setString("id", jasonData['id'].toString());
        sharedPreferences.setString("token", jasonData['token'].toString());
        sharedPreferences.setString("type", jasonData['type'].toString());
        sharedPreferences.setString(
            "activation", jasonData['activation'].toString());

        return "Success";
      } else {
        return "Wrong Response";
      }
    } else {
      return "Server Error";
    }
  }
}
