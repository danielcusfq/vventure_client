import 'package:flutter/material.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:vventure/investor/main/content/profile/controller/communication.dart';

class UserTimelineWidget extends StatefulWidget {
  final List<UserTimeline> timeline;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  final Function removeItem;
  UserTimelineWidget(
      {Key key,
      @required this.timeline,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild,
      @required this.removeItem})
      : super(key: key);

  @override
  _UserTimelineWidgetState createState() => _UserTimelineWidgetState();
}

class _UserTimelineWidgetState extends State<UserTimelineWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  Color secondary = Color.fromRGBO(255, 150, 113, 1);
  TextEditingController detail = new TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "My Timeline",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          onPressed: () {
            detail.text = "";
            dialog(context);
          },
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: myColor,
                size: 50.0,
              ),
              Text(
                "Add",
                style: TextStyle(fontSize: 22),
              ),
              widget.timeline == null
                  ? Container()
                  : Container(
                      child: Timeline.builder(
                        itemBuilder: timelineModel,
                        itemCount: widget.timeline.length,
                        primary: false,
                        shrinkWrap: true,
                      ),
                    ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ],
    );
  }

  TimelineModel timelineModel(BuildContext context, int i) {
    final data = widget.timeline[i];

    return TimelineModel(
        Dismissible(
          onDismissed: (DismissDirection direction) {
            setState(() {
              deleteTimeline(
                  widget.id, widget.token, widget.type, data.idTimeline);
              widget.removeItem(i);
            });
          },
          secondaryBackground: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Delete',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
          background: Container(),
          child: Card(
            color: myColor,
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    detail.text = data.detail;
                  });
                  updateDialog(context, data.idTimeline);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      data.detail,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == widget.timeline.length,
        iconBackground: secondary,
        icon: Icon(
          Icons.adjust,
          color: Colors.white,
        ));
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Add Timeline Entry",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: detail,
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
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          insertTimeline(this.widget.id, this.widget.token,
                              this.widget.type, detail.text);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Submit Timeline Entry",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void updateDialog(context, String idTimeline) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Update Timeline Entry",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: detail,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(132, 94, 194, 1))),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          updateTimeline(this.widget.id, this.widget.token,
                              this.widget.type, idTimeline, detail.text);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Update Timeline Entry",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void insertTimeline(String id, String token, String type, String detail) {
    var future = Communication.insertTimeline(id, token, type, detail);
    future.then((val) {});
  }

  void updateTimeline(
      String id, String token, String type, String idTimeline, String detail) {
    var future =
        Communication.updateTimeline(id, token, type, idTimeline, detail);
    future.then((val) {});
  }

  void deleteTimeline(String id, String token, String type, String idTimeline) {
    var future = Communication.deleteTimeline(id, token, type, idTimeline);
    future.then((val) {});
  }
}
