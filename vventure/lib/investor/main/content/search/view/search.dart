import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/investor/main/common_models/basic_card.dart';
import 'package:vventure/investor/main/common_widgets/proflie_card.dart';
import 'package:vventure/investor/main/content/search/controller/communication.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SharedPreferences sharedPreferences;
  List<BasicCardInfo> _users = new List();
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  Color secondary = Color.fromRGBO(255, 150, 113, 1);
  bool _querySet = false;
  bool _loading = false;
  String id;
  String token;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    getPreferences().then((val) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 100.0,
          backgroundColor: myColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    child: CupertinoTextField(
                      onSubmitted: (String text) {
                        setState(() {
                          _loading = true;
                        });
                        var future =
                            Communication.fetchResults(id, token, text);
                        future.then((value) {
                          setState(() {
                            _users = value;
                            _querySet = true;
                            _loading = false;
                          });
                        });
                      },
                      enableInteractiveSelection: true,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      style: TextStyle(fontSize: 22.0),
                      maxLines: 1,
                      minLines: 1,
                      cursorColor: secondary,
                      keyboardType: TextInputType.text,
                      placeholder: 'Buscar Emprendimiento',
                      placeholderStyle:
                          TextStyle(color: Color(0xffC4C6CC), fontSize: 22.0),
                      prefix: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                        child: Icon(
                          Icons.search,
                          color: secondary,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floating: true,
        ),
        _loading == true
            ? SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
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
                    ),
                  )
                ]),
              )
            : _querySet == false
                ? SliverList(
                    delegate: SliverChildListDelegate([]),
                  )
                : _users == null || _users.isEmpty == true
                    ? SliverList(
                        delegate: SliverChildListDelegate([
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 25,
                                    height: 200,
                                    child: Text(
                                      "No se Encontraron Resultados",
                                      style: TextStyle(fontSize: 24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ProfileCard(
                            id: _users[index].id,
                            organization: _users[index].organization,
                            stage: _users[index].stage,
                            image: _users[index].image,
                            inspection: false,
                          );
                        }, childCount: _users.length),
                      ),
      ],
    );
  }

  Future<dynamic> getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
      token = sharedPreferences.getString("token");
    });
  }
}
