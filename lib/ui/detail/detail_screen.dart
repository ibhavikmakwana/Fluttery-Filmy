import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/detail_bloc.dart';
import 'package:fluttery_filmy/model/movie_list_response.dart';
import 'package:transparent_image/transparent_image.dart';

class Detail extends StatelessWidget {
  final int id;
  final Results result;

  const Detail({Key key, this.id, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailBloc bloc = BlocProvider.of<DetailBloc>(context);
    bloc.getNowPlayingMovies(id);
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: topPadding + 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Card(
                margin: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: result.id.toString(),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: "https://image.tmdb.org/t/p/w500/" +
                          result.backdropPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
