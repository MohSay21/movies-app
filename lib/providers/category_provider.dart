import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/models/show.dart';
import 'package:movies_app/services/api.dart';

final _api = API();
final _show = Show.initial();

final titleProvider = StateNotifierProvider<TitleNotifier, String>(
        (ref) => TitleNotifier()
);
final categoryProvider = FutureProvider.family<List<Show>, String>((ref, title) async =>
getCategory(returnCategory(title))
);

class TitleNotifier extends StateNotifier<String> {

  TitleNotifier() : super('');

  void changeTitle(String title) => state = title;

  String get title => state;

}

Future<List<Show>> getCategory(String cat) async {
  List<Show> shows = [];
  Show show = Show.initial();
  await _api.search(cat).then((List<Show> data) {
    for (var i = 0; i < data.length; i++) {
      show = data[i];
      shows.add(_show.copyWith(
        id: show.id,
        title: show.title,
        poster: show.poster,
      ));
    }
  });
  return shows;
}

String returnCategory(String cat) {
  final result = cat.replaceAll('-', '_').toLowerCase();
  return 'genres=$result';
}