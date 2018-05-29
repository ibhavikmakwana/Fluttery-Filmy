import 'package:flutter/material.dart';
import 'package:flutter_app/onboarding/Walkthrough.dart';
import 'package:flutter_app/onboarding/WalkthroughScreen.dart';

const String _btnNextText = "NEXT";

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<Walkthrough> list = [
    Walkthrough(
      title: "Movies",
      content: "Movies and their reviews at one place",
      imageIcon: Icons.movie_filter,
      imageColor: Colors.redAccent,
    ),
    Walkthrough(
      title: "Popular",
      content: "List of popular movies",
      imageIcon: Icons.favorite,
      imageColor: Colors.redAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new WalkthroughScreen(
      list,
      new MaterialPageRoute(builder: (context) => new Welcome()),
    );
  }
}
