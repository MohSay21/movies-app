import 'package:equatable/equatable.dart';

class Star extends Equatable {

  final String name;
  final String image;
  final String character;

  const Star({
    required this.name,
    required this.image,
    required this.character,
});

  factory Star.fromJSON(Map<String, dynamic> json) => Star(
      name: json["name"],
      image: json["image"],
      character: json["asCharacter"],
  );

  @override
  List<Object?> get props => [name, image, character];

}