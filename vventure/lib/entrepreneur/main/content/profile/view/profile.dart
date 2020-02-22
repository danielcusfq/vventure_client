import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';
import 'package:vventure/entrepreneur/main/common_widgets/custom_video.dart';
import 'package:vventure/entrepreneur/main/common_widgets/log_out.dart';
import 'package:vventure/entrepreneur/main/content/profile/model/my_profile.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/highlights_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/image_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/info_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/loading_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/name_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/organization_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/problem_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/solution_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/stage_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/stake_widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences sharedPreferences;
  String id;
  String token;
  MyProfile _profile;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    getPreferences().then((val) {
      var result = Communication.fetchProfile(id, token);
      result.then((value) {
        setState(() {
          _profile = value;
          _loaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Container(
              child: _loaded == false
                  ? null
                  : CustomVideo(
                      video: _profile.video,
                    ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.715,
                minChildSize: 0.715,
                builder: (BuildContext buildContext, scroll) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 10.0)
                        ]),
                    child: _loaded == false
                        ? LoadingWidget()
                        : ListView(
                            controller: scroll,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              LogOut(),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      backgroundImage:
                                          NetworkImage(_profile.image),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              OrganizationWidget(
                                organization: _profile.organization,
                              ),
                              NameWidget(
                                name: _profile.name,
                                last: _profile.last,
                              ),
                              StageWidget(
                                stage: _profile.stage,
                              ),
                              StakeWidget(
                                stake: _profile.stake,
                                exchange: _profile.stakeInfo,
                              ),
                              ProblemWidget(
                                problem: _profile.problem,
                              ),
                              SolutionWidget(
                                solution: _profile.solution,
                              ),
                              HighlightsWidget(
                                highlights: _profile.highlight,
                                id: id,
                                token: token,
                                type: "1",
                                rebuild: () {
                                  rebuild();
                                },
                                removeItem: (index) {
                                  setState(() {
                                    _profile.highlight.removeAt(index);
                                  });
                                },
                              ),
                              InfoWidget(
                                info: _profile.info,
                                id: id,
                                token: token,
                                type: "1",
                                rebuild: () {
                                  rebuild();
                                },
                                removeItem: (index) {
                                  setState(() {
                                    _profile.info.removeAt(index);
                                  });
                                },
                              ),
                              ImageWidget(
                                images: _profile.images,
                                id: id,
                                token: token,
                                type: "1",
                                rebuild: () {
                                  rebuild();
                                },
                                removeItem: (index) {
                                  setState(() {
                                    _profile.images.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                  );
                },
              ),
            )
          ],
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

  void rebuild() {
    setState(() {
      _loaded = false;
    });
    Timer(Duration(seconds: 1), () {
      var result = Communication.fetchProfile(id, token);
      result.then((value) {
        setState(() {
          _profile = null;
          _profile = value;
          _loaded = true;
        });
      });
    });
  }
}
