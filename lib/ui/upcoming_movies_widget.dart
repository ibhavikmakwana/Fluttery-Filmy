import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/detail_bloc.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/ui/MovieDetailsPage.dart';
import 'package:transparent_image/transparent_image.dart';

class UpcomingMoviesItem extends StatelessWidget {
  final Results result;

  const UpcomingMoviesItem({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
                  child: MovieDetailsPage(
                    id: result.id,
                    result: result,
                  ),
                  bloc: DetailBloc(),
                ),
          ),
        );
      },
      child: Card(
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
              image: "https://image.tmdb.org/t/p/w500/" + result.backdropPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
