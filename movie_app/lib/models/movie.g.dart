// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      title: json['title'] as String,
      overview: json['overview'] as String,
      vote: (json['vote'] as num).toDouble(),
      id: json['id'] as int,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'overview': instance.overview,
      'vote': instance.vote,
      'id': instance.id,
    };
