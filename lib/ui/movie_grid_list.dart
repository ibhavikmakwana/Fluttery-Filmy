import 'package:flutter/material.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/ui/MovieDetailsPage.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieGridList extends StatelessWidget {
  final AsyncSnapshot<MovieResponse> snapshot;

  const MovieGridList({Key key, this.snapshot}) : super(key: key);

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
      return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => GridTileItem(
              result: snapshot.data.results[index],
            ),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Text(snapshot.error.toString()),
      );
    }
  }
}

class GridTileItem extends StatelessWidget {
  final Results result;

  const GridTileItem({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title: Text(result.title),
      ),
      child: GestureDetector(
        onTap: () {
          if (result.id > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MovieDetailsPage(result.id)),
            );
          }
        },
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: "https://image.tmdb.org/t/p/w500/" + result.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
