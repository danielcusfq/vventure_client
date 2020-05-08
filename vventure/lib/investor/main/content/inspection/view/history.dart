import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/inspection/controller/communication.dart';
import 'package:vventure/investor/main/common_models/basic_card.dart';
import 'package:vventure/investor/main/content/inspection/widget/inspection_card.dart';

//this widget displays a list of a previous inspections

class InvestorInspectionHistoryView extends StatefulWidget {
  final String id;
  final String token;
  InvestorInspectionHistoryView(
      {Key key, @required this.id, @required this.token})
      : super(key: key);

  @override
  _InvestorInspectionHistoryViewState createState() =>
      _InvestorInspectionHistoryViewState();
}

class _InvestorInspectionHistoryViewState
    extends State<InvestorInspectionHistoryView> {
  List<BasicCardInfo> _users = new List();
  bool _loading = false;

  //run functions on widget initialization
  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    var list = Communication.fetchInspectionHistory(widget.id, widget.token);
    list.then((value) {
      setState(() {
        _users = value;
        _loading = false;
      });
    });

    super.initState();
  }

  //main view of the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0,
          title: Text(
            "Historial",
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.w200),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(132, 94, 194, 1),
            ),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: _loading == true
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
              child: _users.isEmpty == true
                  ? ListView(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Text(
                              "No Hay Inspecciones Previas",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InspectionCard(
                          investorID: widget.id,
                          token: widget.token,
                          id: _users[index].id,
                          organization: _users[index].organization,
                          stage: _users[index].stage,
                          image: _users[index].image,
                          inspection: _users[index].inspection,
                        );
                      },
                    ),
            ),
    );
  }
}
