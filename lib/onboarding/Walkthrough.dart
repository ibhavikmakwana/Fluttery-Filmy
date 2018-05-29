import 'package:flutter/material.dart';

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final imageIcon;
  final imageColor;

  const Walkthrough(
      {Key key, this.title, this.content, this.imageIcon, this.imageColor})
      : super(key: key);

  @override
  _WalkthroughState createState() {
    return new _WalkthroughState();
  }
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: new Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Center(
                child: new Text(
                  widget.title,
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Center(
                child: new Text(
                  widget.content,
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Center(
                child: new Icon(
                  widget.imageIcon,
                  size: 100.0,
                  color: widget.imageColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
