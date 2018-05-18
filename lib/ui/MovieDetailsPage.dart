import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/TMDBConfig.dart';
import 'package:flutter_app/model/MovieDetail.dart';
import 'package:flutter_app/ui/ActorScroller.dart';
import 'package:flutter_app/ui/MovieDetailHeader.dart';
import 'package:flutter_app/ui/StoryLine.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage(this.id);

  var id;

  MovieDetail detail;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
        future: getMovieDetail(id),
        builder: (BuildContext context, AsyncSnapshot<MovieDetail> snapshot) {
          if (!snapshot.hasData)
            return new Container(
              // Shows progress indicator until the data is load.
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          // Shows the real data with the data retrieved.
          MovieDetail movies = snapshot.data;
          return new CustomScrollView(
            slivers: <Widget>[
              new MovieDetailHeader(movies),
              new Padding(
                padding: const EdgeInsets.all(0.0),
                child: new StoryLine(movies.synopsis),
              ),
              new Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 50.0,
                ),
                child:
                    new ProductionCompaniesScroller(movies.productionCompanies),
              ),
            ],
          );
        },
      ),
    );
  }

  // Method to get now playing movies from the backend
  Future<MovieDetail> getMovieDetail(id) async {
    final String nowPlaying = 'https://api.themoviedb.org/3/movie/' +
        id +
        '?api_key=' +
        TMDBConfig.apiKey +
        '&page=' +
        '1';

    var httpClient = new HttpClient();
    try {
      // Make the call
      var request = await httpClient.getUrl(Uri.parse(nowPlaying));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        // Decode the json response
        var data = jsonDecode(jsonResponse);
        // Get the Movie list
        MovieDetail movieDetail = createDetailList(data);
        // Print the results.
        return movieDetail;
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  MovieDetail createDetailList(data) {
    List<String> genresList = new List();
    List<ProductionCompanies> productionCompaniesList = new List();

    var id = data["id"];
    var title = data["original_title"];
    for (int i = 0; i < data.length; i++) {
      var id = data[i]["id"];
      String name = data[i]["name"];
      String logoPath = data[i]["logo_path"];
      ProductionCompanies productionCompanies =
          new ProductionCompanies(id, name, logoPath);
      productionCompaniesList.add(productionCompanies);
    }
    for (int i = 0; i < data.length; i++) {
      String name = data[i]["name"];
      genresList.add(name);
    }
    var overview = data["overview"];
    var posterPath = data["poster_path"];
    var backdropPath = data["backdrop_path"];
    var voteAverage = data["vote_average"];
    MovieDetail detail = MovieDetail(id, title, genresList, overview,
        posterPath, backdropPath, voteAverage, productionCompaniesList);
    return detail;
  }
}

//  List<MovieDetail> list = new List();
//  for (int i = 0; i < results.length; i++) {
//    var id = data[i]["id"];
//    String title = data[i]["title"];
//    String posterPath = data[i]["poster_path"];
//    String backdropImage = data[i]["backdrop_path"];
//    String originalTitle = data[i]["original_title"];
//    var voteAverage = data[i]["vote_average"];
//    String overview = data[i]["overview"];
//    String releaseDate = data[i]["release_date"];
//
//    PopularMovie movie = new PopularMovie(id, title, posterPath, backdropImage,
//        originalTitle, voteAverage, overview, releaseDate);
//    list.add(movie);
//  }
//  return list;
