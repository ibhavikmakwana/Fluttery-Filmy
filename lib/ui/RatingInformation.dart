import 'package:flutter/material.dart';
import 'package:flutter_app/model/MovieDetail.dart';

class RatingInformation extends StatelessWidget {
  RatingInformation(this.movie);

  final MovieDetail movie;

  _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];
    var rate = movie.voteAverage / 2;
    for (var i = 0; i < 5; ++i) {
      var color = i <= rate ? theme.accentColor : Colors.black12;
      var star = new Icon(
        Icons.star,
        color: color,
      );

      stars.add(star);
    }

    return new Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numericRating = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Text(
          movie.voteAverage.toString(),
          style: textTheme.title
              .copyWith(fontWeight: FontWeight.w400, color: theme.accentColor),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Text(
            'Ratings',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    var starRating = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRatingBar(theme),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: new Text(
            'Grade now',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        numericRating,
        new Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: starRating,
        )
      ],
    );
  }
}
