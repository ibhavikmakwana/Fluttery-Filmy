import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/detail_bloc.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/ui/MovieDetailHeader.dart';
import 'package:fluttery_filmy/ui/ProductionCompaniesScroller.dart';
import 'package:fluttery_filmy/ui/StoryLine.dart';

class MovieDetailsPage extends StatelessWidget {
  final int id;
  final Results result;

  const MovieDetailsPage({Key key, this.id, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailBloc bloc = BlocProvider.of<DetailBloc>(context);
    bloc.getNowPlayingMovies(id);
    return Scaffold(
      body: StreamBuilder<MovieDetail>(
        stream: bloc.movieDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("Result $snapshot");
            return Container(
              // Shows progress indicator until the data is load.
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            MovieDetail movies = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  MovieDetailHeader(movies),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: StoryLine(movies.overview),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 50,
                    ),
                    child:
                        ProductionCompaniesScroller(movies.productionCompanies),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
