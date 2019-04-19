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
    return _WalkthroughState();
  }
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Icon(
                  widget.imageIcon,
                  size: 100,
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
