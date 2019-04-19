import 'dart:async';
import 'dart:convert';
import 'package:fluttery_filmy/TMDBConfig.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  String _baseUrl = "https://api.themoviedb.org/3/movie/";

  Future<NowPlayingMovie> getNowPlayingMovies(int page) async {
    final String nowPlayingUrl =
        "${_baseUrl}now_playing?api_key=${TMDBConfig.apiKey}&page=$page";

    var response = await http.get(nowPlayingUrl);

    if (response.statusCode == 200) {
      print(response.body);
      return NowPlayingMovie.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }
  }
}
