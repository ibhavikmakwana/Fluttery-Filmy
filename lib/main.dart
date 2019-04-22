import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/movies_bloc.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/ui/in_theater_movies.dart';
import 'package:fluttery_filmy/ui/upcoming_movies_widget.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fluttery Filmy",
      theme: ThemeData(
        fontFamily: 'ProzaLibre',
        accentColor: Colors.white,
        textTheme: TextTheme(
          headline: TextStyle(color: Colors.white),
          title: TextStyle(color: Colors.white),
          subtitle: TextStyle(color: Colors.white),
        ),
      ),
      home: BlocProvider(
        child: MainPage(),
        bloc: MoviesBloc(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    MoviesBloc bloc = BlocProvider.of<MoviesBloc>(context);

    bloc.getNowPlayingMovies(1);
    bloc.getUpcomingMovies(1);

    return Scaffold(
      backgroundColor: Color.fromRGBO(53,73,210, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            StreamBuilder<MovieResponse>(
              stream: bloc.nowPlayingMovies,
              builder: (context, snapshot) => Padding(
                    padding: EdgeInsets.only(
                      top: topPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "In theaters",
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                        InTheaterMovies(snapshot: snapshot),
                      ],
                    ),
                  ),
            ),
            StreamBuilder<MovieResponse>(
              stream: bloc.upcomingMovies,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // Shows progress indicator until the data is load.
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Upcoming",
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.results.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => UpcomingMoviesItem(
                              result: snapshot.data.results[index],
                            ),
                      ),
                    ],
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
* 

          StreamBuilder<MovieResponse>(
            stream: bloc.upcomingMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Shows progress indicator until the data is load.
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(16),
                    child: MovieWidget(
                      result: snapshot.data.results[index],
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
            },
          ),
* */
