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
        height: 300,
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
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                      child: MovieDetailsPage(
                        id: result.id,
                      ),
                      bloc: DetailBloc(),
                    ),
              ),
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
