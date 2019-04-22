import 'dart:async';
import 'dart:convert';
import 'package:fluttery_filmy/TMDBConfig.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  String _baseUrl = "https://api.themoviedb.org/3/movie/";

  Future<MovieResponse> getNowPlayingMovies(int page) async {
    final String url =
        "${_baseUrl}now_playing?api_key=${TMDBConfig.apiKey}&page=$page";

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> getPopularMovies(int page) async {
    final String url =
        "${_baseUrl}popular?api_key=${TMDBConfig.apiKey}&page=$page";

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> getUpcomingMovies(int page) async {
    final String url =
        "${_baseUrl}upcoming?api_key=${TMDBConfig.apiKey}&page=$page";

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetail> getMovieDetail(int id) async {
    final String url = 'https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '?api_key=' +
        TMDBConfig.apiKey +
        '&page=' +
        '1';

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movie detail');
    }
  }

//  final String nowPlaying = 'https://api.themoviedb.org/3/movie/' +
//      id.toString() +
//      '?api_key=' +
//      TMDBConfig.apiKey +
//      '&page=' +
//      '1';

}
