import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/TMDBConfig.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';
import 'package:fluttery_filmy/ui/MovieDetailHeader.dart';
import 'package:fluttery_filmy/ui/ProductionCompaniesScroller.dart';
import 'package:fluttery_filmy/ui/StoryLine.dart';
import 'package:http/http.dart' as http;

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage(this.id);

  var id;

  MovieDetail detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetail>(
        future: getMovieDetail(id),
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
                    child: StoryLine(movies.synopsis),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 50,
                    ),
                    child: ProductionCompaniesScroller(
                        movies.productionCompanies),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Method to get now playing movies from the backend
  Future<MovieDetail> getMovieDetail(id) async {
    final String nowPlaying = 'https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '?api_key=' +
        TMDBConfig.apiKey +
        '&page=' +
        '1';

    var httpClient = HttpClient();
    try {
      // Make the call
      final response = await http.get(nowPlaying);
      final responseJson = json.decode(response.body);

//      var request = await httpClient.getUrl(Uri.parse(nowPlaying));
//      var response = await request.close();
//        var jsonResponse = await responseJson .transform(utf8.decoder).join();
      // Decode the json response
//        var data = jsonDecode(jsonResponse);
      // Get the Movie list
      MovieDetail movieDetail = createDetailList(responseJson);
      // Print the results.
      return movieDetail;
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  MovieDetail createDetailList(data) {
    List<String> genresList = List();
    List<ProductionCompanies> productionCompaniesList = List();

    var id = data["id"];
    var title = data["original_title"];
    var productionCompany = data["production_companies"];
    for (int i = 0; i < productionCompany.length; i++) {
      var id = productionCompany[i]["id"];
      String name = productionCompany[i]["name"];
      String logoPath = productionCompany[i]["logo_path"];
      ProductionCompanies productionCompanies =
          ProductionCompanies(id, name, logoPath);
      productionCompaniesList.add(productionCompanies);
    }
    var genres = data["genres"];
    for (int i = 0; i < genres.length; i++) {
      String name = genres[i]["name"];
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

//  List<MovieDetail> list = List();
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
//    PopularMovie movie = PopularMovie(id, title, posterPath, backdropImage,
//        originalTitle, voteAverage, overview, releaseDate);
//    list.add(movie);
//  }
//  return list;
