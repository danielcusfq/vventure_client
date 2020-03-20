import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/entrepreneur/main/common_models/basic_card.dart';
import 'package:vventure/entrepreneur/main/common_widgets/proflie_card.dart';
import 'package:vventure/entrepreneur/main/content/favorites/controller/communication.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator = new GlobalKey();
  SharedPreferences sharedPreferences;
  List<BasicCardInfo> _users = new List();
  String id;
  String token;
  bool _loading;

  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    getPreferences().then((val) {
      var future = Communication.fetchResults(id, token);
      future.then((value) {
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
              child: _users.isEmpty == true
                  ? ListView(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Text(
                              "No Favorites At The Moment",
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
                          name: _users[index].name,
                          last: _users[index].last,
                          image: _users[index].image,
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
    var list = await Communication.fetchResults(id, token);
    setState(() {
      _users = list;
      _loading = false;
    });
  }
}
