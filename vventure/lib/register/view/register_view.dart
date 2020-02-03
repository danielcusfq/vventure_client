import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromRGBO(132, 94, 194, 1),
          bottomOpacity: 0.0,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.7, 0.9, 0.98],
            colors: [
              Color.fromRGBO(132, 94, 194, 1),
              Color.fromRGBO(166, 94, 187, 1),
              Color.fromRGBO(181, 94, 184, 1),
              Color.fromRGBO(214, 93, 177, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: new Image.asset(
                    'assets/images/vventure.png',
                    width: 180,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Text(
                "Register as",
                style: TextStyle(fontSize: 24),
              ),
            ),
            new ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Entrepreneur",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Investor",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _selections.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _selections[buttonIndex] = true;
                    } else {
                      _selections[buttonIndex] = false;
                    }
                  }
                });
              },
              color: Colors.black,
              selectedColor: Color.fromRGBO(255, 150, 113, 1),
              fillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              splashColor: Color.fromRGBO(255, 150, 113, 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
