import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/auth/info.dart';

class Communication {
  // completes registration of entrepreneur user
  static Future<String> completeRegister(
      UserInfo userInfo,
      File image,
      String stage,
      String percentage,
      String exchange,
      String problem,
      String solution) async {
    String _base64image;
    String _ext;
    String _stage;
    String _percentage;
    String _exchange;
    String _problem;
    String _solution;
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

    if (stage.isNotEmpty) {
      _stage = stage;
    } else {
      _stage = "";
    }

    if (percentage.isNotEmpty) {
      _percentage = percentage;
    } else {
      _percentage = "";
    }

    if (exchange.isNotEmpty) {
      _exchange = exchange;
    } else {
      _exchange = "";
    }

    if (problem.isNotEmpty) {
      _problem = problem;
    } else {
      _problem = "";
    }

    if (solution.isNotEmpty) {
      _solution = solution;
    } else {
      _solution = "";
    }

    _data = {
      "auth":
          "b2df705644a0c7ff7dd469afa096c56d6da918cfcf827d69631dcacfccf54fa5",
      "token": userInfo.token,
      "type": userInfo.type,
      "image": _base64image,
      "ext": _ext,
      "stage": _stage,
      "percentage": _percentage,
      "exchange": _exchange,
      "problem": _problem,
      "solution": _solution
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(
        "https://vventure.tk/complete_register/entrepreneur/",
        body: _data);
    Map<String, dynamic> jasonData;

    if (response.statusCode == 200) {
      jasonData = json.decode(response.body);

      if (jasonData['res'].toString() == "success" &&
          jasonData['type'].toString() == "1" &&
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
