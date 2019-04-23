import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/detail_bloc.dart';
import 'package:fluttery_filmy/model/movie_list_response.dart';
import 'package:fluttery_filmy/ui/MovieDetailsPage.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieWidget extends StatelessWidget {
  final Results result;

  const MovieWidget({Key key, this.result}) : super(key: key);

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
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FadeInImage.memoryNetwork(
                  height: 350,
                  width: 300,
                  placeholder: kTransparentImage,
                  image: "https://image.tmdb.org/t/p/w500/" + result.backdropPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  result.originalTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${result.voteAverage}/10",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
