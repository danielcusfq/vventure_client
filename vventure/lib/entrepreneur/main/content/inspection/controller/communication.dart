import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vventure/entrepreneur/main/content/inspection/model/inspection.dart';
import 'package:vventure/entrepreneur/main/content/inspection/model/profile.dart';

//this class helps with the communication with the server

class Communication {
  //this function get a list of the inspections that investors gave to the user
  static Future<List<InvestorBasicProfile>> fetchInspections(
      String id, String token) async {
    id = "&id=" + id;
    token = "&token=" + token;
    String url =
        "https://vventure.tk/entrepreneur/inspection/inspections/?auth=260371ba113efbd41d041970b40b22ce1b9d56b05710cf1453fa739bdd23e71e" +
            id +
            token;
    final response = await http.get(url);
    Map<String, dynamic> jsonData;
    List<InvestorBasicProfile> users = new List();
    List<dynamic> rawData = new List();

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      if (jsonData['res'].toString() == "success") {
        rawData = jsonData['users'];
        rawData.forEach((key) => users.add(new InvestorBasicProfile(
              key['id'].toString(),
              key['organization'].toString(),
              key['name'].toString(),
              key['last'].toString(),
              key['image'].toString(),
              key['inspection'].toString(),
            )));
      }
    }

    return users;
  }

  //this function return all the information of a inspection
  static Future<InspectionModel> fetchInspection(
      String id, String token, String inspection, String investor) async {
    id = "&id=" + id;
    token = "&token=" + token;
    inspection = "&inspection=" + inspection;
    investor = "&investor=" + investor;
    String url =
        "https://vventure.tk/entrepreneur/inspection/detail/?auth=527c3cc5633a9b5ff37f5dade8942166915b6989d38e94f943b377a77719ebcf" +
            id +
            token +
            inspection +
            investor;
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
}
