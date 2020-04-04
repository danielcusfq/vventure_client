import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vventure/investor/main/common_models/highlight.dart';

class HighlightsWidget extends StatefulWidget {
  final List<Highlight> highlights;

  HighlightsWidget({
    Key key,
    @required this.highlights,
  }) : super(key: key);
  @override
  _HighlightsWidgetState createState() => _HighlightsWidgetState();
}

class _HighlightsWidgetState extends State<HighlightsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(
            "Aspectos Destacados",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        this.widget.highlights == null || this.widget.highlights.isEmpty == true
            ? Text("Aspectos Destacados Vacíos")
            : Container(
                child: ListView.builder(
                  primary: false,
                  itemCount: this.widget.highlights.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16.0),
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    this.widget.highlights[index].detail,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
