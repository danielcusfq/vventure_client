import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/entrepreneur/main/content/inspection/controller/communication.dart';
import 'package:vventure/entrepreneur/main/content/inspection/model/profile.dart';
import 'package:vventure/entrepreneur/main/content/inspection/widget/investor_card.dart';

class Inspection extends StatefulWidget {
  @override
  _InspectionState createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator = new GlobalKey();
  SharedPreferences sharedPreferences;
  List<InvestorBasicProfile> _inspections = new List();
  bool _loading = false;
  String id;
  String token;

  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    getPreferences().then((value) {
      var list = Communication.fetchInspections(id, token);
      list.then((value) {
        setState(() {
          _inspections = value;
          _loading = false;
        });
      });
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    super.initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 150, 113, 1)),
                  ),
                ),
              ],
            ),
          )
        : RefreshIndicator(
            key: _refreshIndicator,
            onRefresh: _refresh,
            child: Container(
              color: Colors.white,
              child: _inspections.isEmpty == true
                  ? ListView(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Text(
                              "No Inspections At the Moment",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: _inspections.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InvestorProfileCard(
                          id: _inspections[index].id,
                          inspection: _inspections[index].inspection,
                          image: _inspections[index].image,
                          name: _inspections[index].name,
                          last: _inspections[index].last,
                          organization: _inspections[index].organization,
                        );
                      },
                    ),
            ),
          );
  }

  Future<dynamic> getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
      token = sharedPreferences.getString("token");
    });
  }

  Future<Null> _refresh() async {
    setState(() {
      _loading = true;
    });
    var list = await Communication.fetchInspections(id, token);
    setState(() {
      _inspections = list;
      _loading = false;
    });
  }
}
