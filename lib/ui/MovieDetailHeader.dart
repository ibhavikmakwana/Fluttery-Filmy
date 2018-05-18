import 'package:flutter/material.dart';
import 'package:flutter_app/model/MovieDetail.dart';
import 'package:flutter_app/ui/ArcBannerImage.dart';
import 'package:flutter_app/ui/Poster.dart';
import 'package:flutter_app/ui/RatingInformation.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movies);

  final MovieDetail movies;

  _buildCategotyChips(TextTheme textTheme) {
    return movies.genres.map((category) {
      return new Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: new Chip(
          label: new Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          movies.originalTitle,
          style: textTheme.title,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new RatingInformation(movies),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: new Row(
            children: <Widget>[
              _buildCategotyChips(textTheme),
            ],
          ),
        )
      ],
    );

    return new Stack(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: new ArcBannerImage(movies.backdropPath),
        ),
        new Positioned(
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Poster(
                movies.posterPath,
                height: 180.0,
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
        )
      ],
    );
  }
}
