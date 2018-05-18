//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_app/model/MovieDetail.dart';
//import 'package:meta/meta.dart';
//
//const MethodChannel _channel =
//    const MethodChannel('plugins.flutter.io/url_launcher');
//
//Function(String) launchVideo = (url) async {
//  if (await canLaunch(url)) {
//    await launch(url);
//  }
//};
//
//launch(String url) {}
//
//Future<bool> canLaunch(String url) async {
//  if (url == null) {
//    return false;
//  }
//  return await _channel.invokeMethod(
//    'canLaunch',
//    <String, Object>{'url': url},
//  );
//}
//
//class MoviePoster extends StatelessWidget {
//  static const Key playButtonKey = const Key('playButton');
//
//  MoviePoster({
//    @required this.movieDetail,
//    this.size,
//    this.displayPlayButton = false,
//  });
//
//  final MovieDetail movieDetail;
//  final Size size;
//  final bool displayPlayButton;
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//  }
//}
