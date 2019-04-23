import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/model/movie_list_response.dart';
import 'package:fluttery_filmy/network/DataProvider.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {
  final _nowPlayingMovies = BehaviorSubject<MovieResponse>();
  final _popularMovies = BehaviorSubject<MovieResponse>();
  final _upcomingMovies = BehaviorSubject<MovieResponse>();

  Observable<MovieResponse> get nowPlayingMovies => _nowPlayingMovies.stream;

  Observable<MovieResponse> get popularMovies => _popularMovies.stream;

  Observable<MovieResponse> get upcomingMovies => _upcomingMovies.stream;

  getNowPlayingMovies(int page) {
    DataProvider().getNowPlayingMovies(page).then((value) {
      _nowPlayingMovies.sink.add(value);
    }).catchError((error) {
      _nowPlayingMovies.sink.addError(error);
    });
  }

  getPopularMovies(int page) {
    DataProvider().getPopularMovies(page).then((value) {
      _popularMovies.sink.add(value);
    }).catchError((error) {
      _popularMovies.sink.addError(error);
    });
  }

  getUpcomingMovies(int page) {
    DataProvider().getUpcomingMovies(page).then((value) {
      _upcomingMovies.sink.add(value);
    }).catchError((error) {
      _upcomingMovies.sink.addError(error);
    });
  }

  @override
  void dispose() {
    _nowPlayingMovies.close();
    _popularMovies.close();
    _upcomingMovies.close();
  }
}
