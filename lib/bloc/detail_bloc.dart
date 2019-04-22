import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';
import 'package:fluttery_filmy/network/DataProvider.dart';
import 'package:rxdart/rxdart.dart';

class DetailBloc extends BlocBase {
  final _movieDetail = BehaviorSubject<MovieDetail>();

  Observable<MovieDetail> get movieDetail => _movieDetail.stream;

  getNowPlayingMovies(int id) {
    DataProvider().getMovieDetail(id).then((value) {
      _movieDetail.sink.add(value);
    }).catchError((error) {
      _movieDetail.sink.addError(error);
    });
  }

  @override
  void dispose() {
    _movieDetail.close();
  }
}
