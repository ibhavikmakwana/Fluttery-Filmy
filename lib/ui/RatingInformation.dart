import 'package:flutter/material.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';

class RatingInformation extends StatelessWidget {
  RatingInformation(this.movie);

  final MovieDetail movie;

  _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];
    var rate = movie.voteAverage / 2;
    for (var i = 0; i < 5; ++i) {
      var color = i <= rate ? theme.accentColor : Colors.black12;
      var star = Icon(
        Icons.star,
        color: color,
      );

      stars.add(star);
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          movie.voteAverage.toString(),
          style: textTheme.title
              .copyWith(fontWeight: FontWeight.w400, color: theme.accentColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Ratings',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRatingBar(theme),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            'Grade now',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        numericRating,
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: starRating,
        )
      ],
    );
  }
}
