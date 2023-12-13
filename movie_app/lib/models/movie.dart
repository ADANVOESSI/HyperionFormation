import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;
  final String overview;
  final double vote;
  final int id;

  Movie(
      {required this.title,
      required this.overview,
      required this.vote,
      required this.id});

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
