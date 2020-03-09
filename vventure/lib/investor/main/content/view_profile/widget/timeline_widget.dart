import 'package:flutter/material.dart';
import 'package:vventure/investor/main/common_models/timeline.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class UserTimelineWidget extends StatefulWidget {
  final List<UserTimeline> timeline;
  UserTimelineWidget({
    Key key,
    @required this.timeline,
  }) : super(key: key);

  @override
  _UserTimelineWidgetState createState() => _UserTimelineWidgetState();
}

class _UserTimelineWidgetState extends State<UserTimelineWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  Color secondary = Color.fromRGBO(255, 150, 113, 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "Investor's Timeline",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        widget.timeline == null || widget.timeline.isEmpty == true
            ? Container(
                child: Center(
                  child: Text("Empty Timeline"),
                ),
              )
            : Container(
                child: Timeline.builder(
                  itemBuilder: timelineModel,
                  itemCount: widget.timeline.length,
                  primary: false,
                  shrinkWrap: true,
                ),
              )
      ],
    );
  }

  TimelineModel timelineModel(BuildContext context, int i) {
    final data = widget.timeline[i];

    return TimelineModel(
        Card(
          color: myColor,
          elevation: 8,
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
}
