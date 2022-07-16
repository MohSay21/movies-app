import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/services/api.dart';
import 'package:movies_app/models/show.dart';

final searchMoviesProvider = FutureProvider.family<List<Show>, String>(
        (ref, keyword) async => getMovies(keyword)
);
final searchSeriesProvider = FutureProvider.family<List<Show>, String>(
        (ref, keyword) async => getSeries(keyword)
);
final searchProvider = StateNotifierProvider<SearchNotifier, String>(
        (ref) => SearchNotifier()
);
final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>(
        (ref) => SearchHistoryNotifier()
);
final isMoviesProvider = StateNotifierProvider<IsMoviesNotifier, bool>(
    (ref) => IsMoviesNotifier()
);


final _api = API();
final _show = Show.initial();

  Future<List<Show>> getMovies(String keyWord) async {
    List<Show> movies = [];
    late Show movie;
    await _api.searchMovies(keyWord).then((List<Show> data) {
      for (var i = 0; i < data.length; i++) {
        movie = data[i];
        movies.add(_show.copyWith(
          id: movie.id,
          title: movie.title,
          poster: movie.poster,
        ));
      }
    });
    return movies;
  }

  Future<List<Show>> getSeries(String keyWord) async {
    List<Show> series = [];
    late Show serie;
    await _api.searchSeries(keyWord).then((List<Show> data) {
      for (var i = 0; i < data.length; i++) {
        serie = data[i];
        series.add(_show.copyWith(
          id: serie.id,
          title: serie.title,
          poster: serie.poster,
        ));
      }
    });
    return series;
  }

class SearchNotifier extends StateNotifier<String> {

    SearchNotifier() : super('');

    void setKeyword(String keyword) => state = keyword;

    String get keyword => state;

}

class SearchHistoryNotifier extends StateNotifier<List<String>> {

    SearchHistoryNotifier() : super([]);

    void addSearch(String search) {
      List<String> items = [...state];
      items.add(search);
      state = items;
    }

    void removeSearch(int idx) {
      List<String> items = [...state];
      items.removeAt(idx);
      state = items;
    }

    List<String> get history => state;

}

class IsMoviesNotifier extends StateNotifier<bool> {

    IsMoviesNotifier() : super(false);

    void changeState()
    {
      final newState = !state;
      state = newState;
    }

}