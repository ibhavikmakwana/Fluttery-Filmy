import 'package:flutter/material.dart';
import 'package:fluttery_filmy/onboarding/Walkthrough.dart';
import 'package:fluttery_filmy/onboarding/WalkthroughScreen.dart';

const String _btnNextText = "NEXT";

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    return WalkthroughScreen(
      list,
      MaterialPageRoute(builder: (context) => Welcome()),
    );
  }
}
