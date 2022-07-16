import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/models/details.dart';
import 'package:movies_app/models/show.dart';

Show _show = Show.initial();

final mylistProvider = StateNotifierProvider<MylistNotifier, List<Show>>(
        (ref) => MylistNotifier()
);

class MylistNotifier extends StateNotifier<List<Show>> {

  MylistNotifier() : super([]);

  void addShow(Details show) =>
    state.add(_show.copyWith(
      id: show.id,
      title: show.title,
      poster: show.poster,
    ));

  void removeShow(Details show) {
    _show = _show.copyWith(
      id: show.id,
      title: show.title,
      poster: show.poster,
    );
    state.remove(show);
  }

  List<Show> get mylist => state;

}