import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttery_filmy/TMDBConfig.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/model/PopularMovie.dart';
import 'package:fluttery_filmy/model/UpcomingMovie.dart';
import 'package:fluttery_filmy/ui/MovieDetailsPage.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MainApp());


class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fluttery Filmy",
      home: MainPage(),
    );
  }
}

// Method to get now playing movies from the backend
Future<List<NowPlayingMovie>> getNowPlayingMovies() async {
  final String nowPlaying =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=' +
          TMDBConfig.apiKey +
          '&page=' +
          '1';

  var httpClient = HttpClient();
  try {
    // Make the call
    var request = await httpClient.getUrl(Uri.parse(nowPlaying));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      // Decode the json response
      var data = jsonDecode(jsonResponse);
      // Get the result list
      List results = data["results"];
      // Get the Movie list
      List<NowPlayingMovie> movieList = createNowPlayingMovieList(results);
      // Print the results.
      return movieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

// Method to get Upcoming movies from the backend
Future<List<UpcomingMovie>> getUpcomingMovies() async {
  final String nowPlaying =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=' +
          TMDBConfig.apiKey +
          '&page=' +
          '1';

  var httpClient = HttpClient();
  try {
    // Make the call
    var request = await httpClient.getUrl(Uri.parse(nowPlaying));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      // Decode the json response
      var data = jsonDecode(jsonResponse);
      // Get the result list
      List results = data["results"];
      // Get the Movie list
      List<UpcomingMovie> movieList = createUpcomingMovieList(results);
      // Print the results.
      return movieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

// Method to get Popular movies from the backend
Future<List<PopularMovie>> getPopularMovies() async {
  final String nowPlaying =
      'https://api.themoviedb.org/3/movie/popular?api_key=' +
          TMDBConfig.apiKey +
          '&page=' +
          '1';

  var httpClient = HttpClient();
  try {
    // Make the call
    var request = await httpClient.getUrl(Uri.parse(nowPlaying));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      // Decode the json response
      var data = jsonDecode(jsonResponse);
      // Get the result list
      List results = data["results"];
      // Get the Movie list
      List<PopularMovie> movieList = createPopularMovieList(results);
      // Print the results.
      return movieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

/// Method to parse information from the retrieved data
List<NowPlayingMovie> createNowPlayingMovieList(List data) {
  List<NowPlayingMovie> list = List();
  for (int i = 0; i < data.length; i++) {
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropImage = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    NowPlayingMovie movie = NowPlayingMovie(
        id,
        title,
        posterPath,
        backdropImage, originalTitle, voteAverage, overview, releaseDate);
    list.add(movie);
  }
  return list;
}

/// Method to parse information from the retrieved data
List<UpcomingMovie> createUpcomingMovieList(List data) {
  List<UpcomingMovie> list = List();
  for (int i = 0; i < data.length; i++) {
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropImage = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    UpcomingMovie movie = UpcomingMovie(
        id,
        title,
        posterPath,
        backdropImage,
        originalTitle,
        voteAverage,
        overview,
        releaseDate);
    list.add(movie);
  }
  return list;
}

/// Method to parse information from the retrieved data
List<PopularMovie> createPopularMovieList(List data) {
  List<PopularMovie> list = List();
  for (int i = 0; i < data.length; i++) {
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropImage = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    PopularMovie movie = PopularMovie(
        id,
        title,
        posterPath,
        backdropImage,
        originalTitle, voteAverage, overview, releaseDate);
    list.add(movie);
  }
  return list;
}

// create a card layout for the now playing movie
List<Widget> createNowPlayingMovieCardItem(
    List<NowPlayingMovie> movies, BuildContext context) {
  // Children list for the list.
  List<Widget> listElementWidgetList = List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (int i = 0; i < lengthOfList; i++) {
      NowPlayingMovie movie = movies[i];
      // Image URL
      var imageURL = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // List item created with an image of the poster
      var listItem = GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(movie.title),
          ),
          child: GestureDetector(
            onTap: () {
              if (movie.id > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(movie.id)),
                );
              }
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageURL,
              fit: BoxFit.cover,
            ),
          ));
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}

// create a card layout for the upcoming movie
List<Widget> createUpcomingMovieCardItem(
    List<UpcomingMovie> movies, BuildContext context) {
  // Children list for the list.
  List<Widget> listElementWidgetList = List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (int i = 0; i < lengthOfList; i++) {
      UpcomingMovie movie = movies[i];
      // Image URL
      var imageURL = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // List item created with an image of the poster
      var listItem = GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(movie.title),
          ),
          child: GestureDetector(
            onTap: () {
              if (movie.id > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(movie.id)),
                );
              }
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageURL,
              fit: BoxFit.cover,
            ),
          ));
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}


// create a card layout for the popular movie
List<Widget> createPopularMovieCardItem(
    List<PopularMovie> movies, BuildContext context) {
  // Children list for the list.
  List<Widget> listElementWidgetList = List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (int i = 0; i < lengthOfList; i++) {
      PopularMovie movie = movies[i];
      // Image URL
      var imageURL = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // List item created with an image of the poster
      var listItem = GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(movie.title),
          ),
          child: GestureDetector(
            onTap: () {
              if (movie.id > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(movie.id)),
                );
              }
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageURL,
              fit: BoxFit.cover,
            ),
          ));
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  /// This controller can be used to programmatically
  /// set the current displayed page
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttery Movies'),
      ),
      body: PageView(
        children: <Widget>[
          //Now Playing
          Offstage(
            offstage: _page != 0,
            child: TickerMode(
              enabled: _page == 0,
              child: FutureBuilder(
                  future: getNowPlayingMovies(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children:
                                createNowPlayingMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          //Upcoming
          Offstage(
            offstage: _page != 1,
            child: TickerMode(
              enabled: _page == 1,
              child: FutureBuilder(
                  future: getUpcomingMovies(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children:
                                createUpcomingMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          //Popular
          Offstage(
            offstage: _page != 2,
            child: TickerMode(
              enabled: _page == 2,
              child: FutureBuilder(
                  future: getPopularMovies(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children:
                                createPopularMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.event_seat), title: Text("Now Playing")),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text("Upcoming")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Popular")),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  /// Called when the user presses on of the
  /// [BottomNavigationBarItem] with corresponding
  /// page index
  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
