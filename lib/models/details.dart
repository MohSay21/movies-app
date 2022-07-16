import 'package:equatable/equatable.dart';
import 'package:movies_app/models/show.dart';
import 'package:movies_app/models/star.dart';

class Details extends Equatable {

  final String id;
  final String title;
  final String type;
  final String poster;
  final String length;
  final String plot;
  final List<Star> stars;
  final List<String> genres;
  final String rating;
  final List<Show> similars;

  const Details({
    required this.id,
    required this.title,
    required this.type,
    required this.poster,
    required this.length,
    required this.plot,
    required this.stars,
    required this.genres,
    required this.rating,
    required this.similars,
});

  factory Details.initial() => const Details(
    id: '',
    title: '',
    type: '',
    poster: '',
    length: '',
    plot: '',
    stars: [],
    genres: [],
    rating: '',
    similars: [],
  );

  factory Details.fromJSON(Map<String, dynamic> json) {
    return Details(
      id: json["id"],
      title: json["fullTitle"],
      type: json["type"],
      poster: json["image"],
      length: json["type"] == "Movie"
      ? json["runtimeMins"] : '${json["tvSeriesInfo"]["seasons"].length}',
      plot: json["plot"],
      stars: List.generate(5, (idx) => Star.fromJSON(json["actorList"][idx])),
      genres: List.generate(3, (idx) => json["genreList"][idx]["value"]),
      rating: json["imDbRating"],
      similars: List.generate(10, (idx) => Show.fromJSON(json["similars"][idx])),
    );
  }

  Details copyWith({
    String? id,
    String? title,
    String? type,
    String? poster,
    String? length,
    String? plot,
    List<Star>? stars,
    List<String>? genres,
    String? rating,
    List<Show>? similars,
}) => Details(
    id: id ?? this.id,
    title: title ?? this.title,
    type: type ?? this.type,
    poster: poster ?? this.poster,
    length: length ?? this.length,
    plot: plot ?? this.plot,
    stars: stars ?? this.stars,
    genres: genres ?? this.genres,
    rating: rating ?? this.rating,
    similars: similars ?? this.similars,
  );

  @override
  List<Object?> get props => [id, title, type, poster, length, plot, stars, genres, rating, similars];

}