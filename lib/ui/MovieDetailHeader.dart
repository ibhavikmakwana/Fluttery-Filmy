import 'package:flutter/material.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';
import 'package:fluttery_filmy/ui/ArcBannerImage.dart';
import 'package:fluttery_filmy/ui/Poster.dart';
import 'package:fluttery_filmy/ui/RatingInformation.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movies);

  final MovieDetail movies;

  _buildCategoryChips(TextTheme textTheme) {
    return movies.genres.map((genres) {
      return Chip(
        label: Text(genres),
        labelStyle: textTheme.caption,
        backgroundColor: Colors.black12,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            movies.originalTitle,
            style: textTheme.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: RatingInformation(movies),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        )
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 240),
          child: ArcBannerImage(
              "https://image.tmdb.org/t/p/w500/" + movies.backdropPath),
        ),
        Positioned(
          bottom: 32,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Poster(
                  "https://image.tmdb.org/t/p/w500/" + movies.posterPath,
                  height: 190,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}