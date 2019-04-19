import 'package:flutter/material.dart';
import 'package:fluttery_filmy/main.dart';
import 'package:fluttery_filmy/onboarding/Walkthrough.dart';

class WalkthroughScreen extends StatefulWidget {
  final List<Walkthrough> walkthroughList;
  final MaterialPageRoute pageRoute;

  WalkthroughScreen(this.walkthroughList, this.pageRoute);

  @override
  WalkthroughScreenState createState() {
    return WalkthroughScreenState();
  }
}

class WalkthroughScreenState extends State<WalkthroughScreen> {
  PageController _controller;
  bool lastScreen = false;
  int _currentScreen = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC5CAE9),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Material(
              child: PageView(
                children: widget.walkthroughList,
                controller: _controller,
                onPageChanged: _onPageChanged,
              ),
              elevation: 8.0,
            ),
            flex: 10,
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: double.infinity,
                minWidth: double.infinity,
              ),
              child: MaterialButton(
                onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainApp(),
                      ),
                    ),
                color: Colors.lightBlueAccent,
                splashColor: Colors.redAccent,
                elevation: 8.0,
                textColor: Colors.white,
                child: Text(
                  "Let's Start",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            flex: 1,
          ),
//          Expanded(
//            flex: 1,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                SizedBox(
//                  width: double.infinity,
//                  child: MaterialButton(
//                    onPressed: (){
//                      setState(() {
//
//                      });
//                    },
//                    color: Colors.lightBlueAccent,
//                    splashColor: Colors.redAccent,
//                    elevation: 8.0,
//                    child: Text("Next"),
//                  ),
//                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

  void _onPageChanged(int value) {
    setState(() {
      _currentScreen = value;
      if (_currentScreen == widget.walkthroughList.length - 1) {
        lastScreen = true;
      } else {
        lastScreen = false;
      }
    });
  }
}
