import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/detail_bloc.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/ui/MovieDetailsPage.dart';
import 'package:fluttery_filmy/ui/horizontal_movie_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class InTheaterMovies extends StatelessWidget {
  final AsyncSnapshot<MovieResponse> snapshot;

  const InTheaterMovies({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!snapshot.hasData) {
      // Shows progress indicator until the data is load.
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (snapshot.hasData) {
      return SizedBox(
        height: 450,
        child: ListView.builder(
          itemCount: snapshot.data.results.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(16),
                child: MovieWidget(
                  result: snapshot.data.results[index],
                ),
              ),
        ),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Text(snapshot.error.toString()),
      );
    } else {
      return Center(
        child: Text("Something went wrong"),
      );
    }
  }
}
