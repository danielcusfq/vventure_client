import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/basic_profile/entrepreneur/controller/communication.dart';
import 'package:vventure/entrepreneur/main/view/home_view.dart';

class BasicProfileEntView extends StatefulWidget {
  final UserInfo userInfo;
  BasicProfileEntView({Key key, @required this.userInfo}) : super(key: key);

  @override
  _BasicProfileEntViewState createState() => _BasicProfileEntViewState();
}

class _BasicProfileEntViewState extends State<BasicProfileEntView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image;
  TextEditingController percentage = new TextEditingController();
  TextEditingController exchange = new TextEditingController();
  List<String> _dropItems = ["Concept", "Prototipe", "Production", "Scaling"];
  String stage = "";
  TextEditingController problem = new TextEditingController();
  TextEditingController solution = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _isLoading
            ? null
            : AppBar(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to VVENTURE",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromRGBO(132, 94, 194, 1)),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(132, 94, 194, 1),
                  ),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginView()),
                      (Route<dynamic> route) => false),
                ),
                bottom: TabBar(
                  unselectedLabelColor: Color.fromRGBO(132, 94, 194, 1),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Color.fromRGBO(132, 94, 194, 1)),
                  tabs: <Widget>[
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Profile Picture"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Stage & Stakes"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Problem & Solution"),
                      ),
                    )
                  ],
                ),
              ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 150, 113, 1))))
            : TabBarView(
                children: <Widget>[
                  // column that contains load image -- first tab
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: _image == null
                              ? Image.asset(
                                  'assets/images/add_profile_image.png',
                                  width: 150,
                                  height: 150,
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.height / 3,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(_image),
                                          fit: BoxFit.fill)),
                                ),
                        ),
                        FlatButton(
                          onPressed: getImage,
                          child: Text(
                            "Add Profile Image",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(132, 94, 194, 1)),
                          ),
                        ),
                        Container(
                          height: 5,
                        )
                      ],
                      //child: _image == null ? Text('No image selected.') : Image.file(_image),
                    ),
                  ),
                  // -----------------------------------------------------------
                  // container that wraps stake and stage inputs -- second tab
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "What’s the Stage of Your Project?",
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton<String>(
                            items: _dropItems.map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Center(child: Text(val)),
                              );
                            }).toList(),
                            hint: stage.isNotEmpty
                                ? Text(stage)
                                : Text("Select Project Stage"),
                            onChanged: (String val) {
                              stage = val;
                              setState(() {});
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Percentage to Give Up",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                controller: percentage,
                                cursorColor: Color.fromRGBO(132, 94, 194, 1),
                                style: TextStyle(
                                    color: Color.fromRGBO(132, 94, 194, 1),
                                    fontSize: 20),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                maxLength: 2,
                                decoration: new InputDecoration(
                                  labelStyle: new TextStyle(
                                      color: Color.fromRGBO(132, 94, 194, 1),
                                      fontSize: 20),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color:
                                              Color.fromRGBO(132, 94, 194, 1))),
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                            Text(
                              "%",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "In Exchange of",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: exchange,
                            cursorColor: Color.fromRGBO(132, 94, 194, 1),
                            style: TextStyle(
                                color: Color.fromRGBO(132, 94, 194, 1),
                                fontSize: 20),
                            keyboardType: TextInputType.text,
                            minLines: 3,
                            maxLines: 3,
                            decoration: new InputDecoration(
                              labelStyle: new TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(132, 94, 194, 1))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // --------------------------------------------------------
                  // problem and solution -- third tab
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "What Problem Are You Solving",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: problem,
                            cursorColor: Color.fromRGBO(132, 94, 194, 1),
                            style: TextStyle(
                                color: Color.fromRGBO(132, 94, 194, 1),
                                fontSize: 20),
                            keyboardType: TextInputType.text,
                            minLines: 3,
                            maxLines: 3,
                            decoration: new InputDecoration(
                              labelStyle: new TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(132, 94, 194, 1))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "How Are You Solving This Problem",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: solution,
                            cursorColor: Color.fromRGBO(132, 94, 194, 1),
                            style: TextStyle(
                                color: Color.fromRGBO(132, 94, 194, 1),
                                fontSize: 20),
                            keyboardType: TextInputType.text,
                            minLines: 3,
                            maxLines: 3,
                            decoration: new InputDecoration(
                              labelStyle: new TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(132, 94, 194, 1))),
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });

                            completeRegister(
                                this.widget.userInfo,
                                _image,
                                stage,
                                percentage.text,
                                exchange.text,
                                problem.text,
                                solution.text);
                          },
                          child: Text(
                            "Finish",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(132, 94, 194, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void completeRegister(UserInfo userInfo, File image, String stage,
      String percentage, String exchange, String problem, String solution) {
    var future = Communication.completeRegister(
        userInfo, image, stage, percentage, exchange, problem, solution);

    future.then((result) {
      // manages result from server
      if (result.toString() == "Success") {
        // redirects user to home page
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => EntrepreneurHomeView()),
            (Route<dynamic> route) => false);
      } else if (result.toString() == "Activated") {
        // redirects user to log in
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginView()),
            (Route<dynamic> route) => false);
      } else if (result.toString() == "Wrong Response") {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('Server Error'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else if (result.toString() == "Server Error") {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('Server Error'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('An Error Ocurred'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }
}
