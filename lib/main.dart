import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/bloc/movies_bloc.dart';
import 'package:fluttery_filmy/bloc/navigation_bloc.dart';
import 'package:fluttery_filmy/model/NowPlayingMovie.dart';
import 'package:fluttery_filmy/model/enum_util.dart';
import 'package:fluttery_filmy/ui/movie_grid_list.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fluttery Filmy",
      home: BlocProvider(
        child: BlocProvider(
          child: MainPage(),
          bloc: NavigationBloc(),
        ),
        bloc: MoviesBloc(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = BlocProvider.of<MoviesBloc>(context);
    NavigationBloc navBloc = BlocProvider.of<NavigationBloc>(context);

    bloc.getNowPlayingMovies(1);
    bloc.getPopularMovies(1);
    bloc.getUpcomingMovies(1);

    return StreamBuilder<BottomNavBarItem>(
      stream: navBloc.navBar,
      initialData: navBloc.defaultItem,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Fluttery Filmy'),
          ),
          body: PageView(
            controller: navBloc.controller,
            children: <Widget>[
              //Now Playing
              StreamBuilder<MovieResponse>(
                stream: bloc.nowPlayingMovies,
                builder: (context, snapshot) =>
                    MovieGridList(snapshot: snapshot),
              ),

              StreamBuilder<MovieResponse>(
                stream: bloc.upcomingMovies,
                builder: (context, snapshot) =>
                    MovieGridList(snapshot: snapshot),
              ),

              StreamBuilder<MovieResponse>(
                stream: bloc.popularMovies,
                builder: (context, snapshot) =>
                    MovieGridList(snapshot: snapshot),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: navBloc.pickItem,
            currentIndex: snapshot.data.index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.event_seat), title: Text("Now Playing")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event), title: Text("Upcoming")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), title: Text("Popular")),
            ],
          ),
        );
      },
    );
  }
}
