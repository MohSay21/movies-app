import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/services/api.dart';
import 'package:movies_app/models/show.dart';

final _api = API();
final _show = Show.initial();
final _random = Random();

final popularMoviesProvider = FutureProvider<List<Show>>((ref) =>
    getMovies()
);
final popularSeriesProvider = FutureProvider<List<Show>>((ref) =>
    getSeries()
);
final miniseriesProvider = FutureProvider<List<Show>>((ref) =>
    getMiniseries()
);

  Future<List<Show>> getMovies() async {
    List<Show> movies = [];
    Show movie = Show.initial();
    await _api.popularMovies().then((List<Show> data) {
      for (var i = 0; i < data.length; i++) {
        movie = data[i];
        movies.add(_show.copyWith(
          id: movie.id,
          poster: movie.poster,
          title: movie.title,
        ));
      }
    }
    );
    return movies;
  }

  Future<List<Show>> getSeries() async {
    List<Show> series = [];
    Show serie = Show.initial();
    await _api.popularSeries().then((List<Show> data) {
      for (var i = 0; i < data.length; i++) {
        serie = data[i];
        series.add(_show.copyWith(
          id: serie.id,
          poster: serie.poster,
          title: serie.title,
        ));
      }
    });
    return series;
  }

Future<List<Show>> getMiniseries() async {
  List<Show> shows = [];
  Show show = Show.initial();
  await _api.search('title_type=tv_miniseries').then((List<Show> data) {
    for (var i = 0; i < data.length; i++) {
      show = data[i];
      shows.add(_show.copyWith(
        id: show.id,
        poster: show.poster,
        title: show.title,
      ));
    }
  });
  return shows;
}

List<Show> getRandom(List<Show> shows) {
    List<Show> result = [];
    Show show = Show.initial();
    int x = 0, y = 0;
      for (var i = 0; i < 15; i++) {
        do {
          x = _random.nextInt(shows.length);
        } while (x == y);
        y = x;
        show = shows[y];
        result.add(show);
      }
    return result;
}