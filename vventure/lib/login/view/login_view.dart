import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<bool> _selections = List.generate(2, (_) => false);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6, 0.8, 0.9],
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
                  padding: const EdgeInsets.all(30.0),
                  child: new Image.asset(
                    'assets/images/vventure.png',
                    width: 250,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Text(
                "LogIn as",
                style: TextStyle(fontSize: 26),
              ),
            ),
            new ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Entrepreneur",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Investor",
                    style: TextStyle(fontSize: 22),
                  ),
                )
              ],
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  //_selections[index] = !_selections[index];
                  for (int buttonIndex = 0;
                      buttonIndex < _selections.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _selections[buttonIndex] = !_selections[buttonIndex];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextField(
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: const Color(0xFF424242), fontSize: 24),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: 'Email',
                            labelStyle: new TextStyle(
                                color: const Color(0xFF424242), fontSize: 26),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                          ),
                        ),
                        constraints:
                            BoxConstraints(minWidth: 300, maxWidth: 400),
                      ),
                      Container(
                        child: TextField(
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: const Color(0xFF424242), fontSize: 24),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: new InputDecoration(
                            labelText: 'Password',
                            labelStyle: new TextStyle(
                                color: const Color(0xFF424242), fontSize: 26),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                          ),
                          obscureText: true,
                        ),
                        constraints:
                            BoxConstraints(minWidth: 300, maxWidth: 400),
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () => {},
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        constraints: BoxConstraints(minWidth: 300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => {},
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
