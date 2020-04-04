import 'package:flutter/material.dart';
import 'package:vventure/investor/main/common_models/basic_card.dart';
import 'package:vventure/investor/main/common_widgets/proflie_card.dart';
import 'package:vventure/investor/main/content/inspection/controller/communication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/investor/main/content/inspection/view/history.dart';

class Inspection extends StatefulWidget {
  @override
  _InspectionState createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator = new GlobalKey();
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  Color secondary = Color.fromRGBO(255, 150, 113, 1);
  SharedPreferences sharedPreferences;
  List<BasicCardInfo> _users = new List();
  bool _loading = false;
  String id;
  String token;

  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    getPreferences().then((value) {
      var list = Communication.fetchUsers(id, token);
      list.then((value) {
        setState(() {
          _users = value;
          _loading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading == true
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
                child: _users.isEmpty == true
                    ? ListView(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Text(
                                "No Hay Inspecciones en Este Momento",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProfileCard(
                            id: _users[index].id,
                            organization: _users[index].organization,
                            stage: _users[index].stage,
                            image: _users[index].image,
                            inspection: true,
                            inspectionid: _users[index].inspection,
                          );
                        },
                      ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  InvestorInspectionHistoryView(id: id, token: token),
            ),
          );
        },
        child: Icon(Icons.history),
        backgroundColor: secondary,
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
    var list = await Communication.fetchUsers(id, token);
    setState(() {
      _users = list;
      _loading = false;
    });
  }
}
