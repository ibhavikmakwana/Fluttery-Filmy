import 'package:flutter/material.dart';

class StoryLine extends StatelessWidget {
  StoryLine(this.storyline);

  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: new Text(
            'Synopsis',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: new Text(
            storyline,
            style:
                textTheme.body1.copyWith(color: Colors.black45, fontSize: 16.0),
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              new Text(
                'more',
                style: textTheme.body1
                    .copyWith(fontSize: 16.0, color: theme.accentColor),
              ),
              new Icon(
                Icons.keyboard_arrow_down,
                size: 18.0,
                color: theme.accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
