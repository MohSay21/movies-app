import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/services/api.dart';
import 'package:movies_app/models/details.dart';

final _api = API();

final selectedShowProvider = StateNotifierProvider<ShowNotifier, String>(
    (ref) => ShowNotifier()
);
final showProvider = FutureProvider.family<Details, String>((ref, id) async =>
    _api.getDetails(id)
);

class ShowNotifier extends StateNotifier<String> {

  ShowNotifier() : super('');

  void changeShow(String id) => state = id;

  String get id => state;

}

Future<Details> getDetails(String id) async {
  Details details = Details.initial();
  Details result = Details.initial();
  await _api.getDetails(id).then((value) {
    result = details.copyWith(
      id: value.id,
      title: value.title,
      type: value.type,
      poster: value.poster,
      length: value.length,
      plot: value.plot,
      stars: value.stars,
      genres: value.genres,
      similars: value.similars,
      rating: value.rating
    );
  });
  return result;
}