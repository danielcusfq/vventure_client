import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/investor/main/content/profile/controller/communication.dart';
import 'package:vventure/investor/main/content/profile/widget/custom_video.dart';
import 'package:vventure/investor/main/content/profile/widget/log_out.dart';
import 'package:vventure/investor/main/content/profile/model/my_profile.dart';
import 'package:vventure/investor/main/content/profile/widget/highlights_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/image_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/info_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/loading_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/name_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/organization_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/interests.dart';
import 'package:vventure/investor/main/content/profile/widget/profile_image_widget.dart';
import 'package:vventure/investor/main/content/profile/widget/background.dart';

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
      child: _loaded == false
          ? Center(child: LoadingWidget())
          : SizedBox.expand(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: CustomVideo(
                        video: _profile.video,
                        id: id,
                        token: token,
                        type: "2",
                        rebuild: () {
                          rebuild();
                        }),
                  ),
                  SizedBox.expand(
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.715,
                      minChildSize: 0.715,
                      builder: (BuildContext buildContext, scroll) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 10.0)
                              ]),
                          child: ListView(
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
                              ProfileImageWidget(
                                image: _profile.image,
                                id: id,
                                token: token,
                                type: "2",
                                rebuild: () {
                                  rebuild();
                                },
                              ),
                              OrganizationWidget(
                                organization: _profile.organization,
                                id: id,
                                token: token,
                                type: "2",
                                rebuild: () {
                                  rebuild();
                                },
                              ),
                              NameWidget(
                                name: _profile.name,
                                last: _profile.last,
                                id: id,
                                token: token,
                                type: "2",
                                rebuild: () {
                                  rebuild();
                                },
                              ),
                              InterestsWidget(
                                interest: _profile.interests,
                                id: id,
                                token: token,
                                type: "2",
                                rebuild: () {
                                  rebuild();
                                },
                              ),
                              BackgroundWidget(
                                background: _profile.background,
                                id: id,
                                token: token,
                                type: "2",
                                rebuild: () {
                                  rebuild();
                                },
                              ),
                              HighlightsWidget(
                                highlights: _profile.highlight,
                                id: id,
                                token: token,
                                type: "2",
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
                                type: "2",
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
                                  type: "2",
                                  rebuild: () {
                                    rebuild();
                                  },
                                  removeItem: (index) {
                                    setState(() {
                                      _profile.images.removeAt(index);
                                    });
                                  }),
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
    Timer(Duration(seconds: 2), () {
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

  void loading() {
    setState(() {
      _loaded = false;
    });
  }
}
