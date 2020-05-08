import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/common_models/basic_card.dart';
import 'package:vventure/entrepreneur/main/common_widgets/proflie_card.dart';
import 'package:vventure/entrepreneur/main/content/home/controller/fetch_results.dart';

class MainResults extends StatefulWidget {
  @override
  _MainResultsState createState() => _MainResultsState();
}

class _MainResultsState extends State<MainResults> {
  List<BasicCardInfo> _users = new List();
  bool _loading = false;

  //functions run at server initialize
  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    var list = FetchResults.fetchResults();
    list.then((value) {
      setState(() {
        _users = value;
        _loading = false;
      });
    });
    super.initState();
  }

  //main view for the home module
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
        : Container(
            color: Colors.white,
            child: ListView.builder(
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
          );
  }
}
