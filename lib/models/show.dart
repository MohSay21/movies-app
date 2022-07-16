import 'package:equatable/equatable.dart';

class Show extends Equatable {

  final String id;
  final String poster;
  final String title;

  const Show({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory Show.initial() => const Show(id: '', poster: '', title: '');

  factory Show.fromJSON(Map<String, dynamic> json) {
    return Show(
      id: json["id"],
      poster: json["image"],
      title: json["title"],
    );
  }

  Show copyWith({
    String? id,
    String? poster,
    String? title,
  }) => Show(
      id: id ?? this.id,
      poster: poster ?? this.poster,
      title: title ?? this.title,
    );

  @override
  List<Object?> get props => [id, poster, title];

}