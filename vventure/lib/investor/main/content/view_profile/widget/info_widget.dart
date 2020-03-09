import 'package:flutter/material.dart';
import 'package:vventure/investor/main/common_models/info.dart';

class InfoWidget extends StatefulWidget {
  final List<Info> info;

  InfoWidget({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  _InfoWidgetState createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "Information",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        this.widget.info == null || this.widget.info.isEmpty == true
            ? Container(
                child: Center(
                  child: Text("Empty Info"),
                ),
              )
            : Container(
                child: ListView.builder(
                  primary: false,
                  itemCount: this.widget.info.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16.0),
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      this.widget.info[index].title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    this.widget.info[index].content,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      key: UniqueKey(),
                    );
                  },
                ),
              )
      ],
    );
  }
}
