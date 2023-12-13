import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie.dart';

enum AddEditMovieStatus { initial, loading, success, failure }

extension AddEditStatusX on AddEditMovieStatus {
  bool get isLoadingOrSuccess => [
        AddEditMovieStatus.loading,
        AddEditMovieStatus.success,
      ].contains(this);
}

final class AddEditMovieState extends Equatable {
  const AddEditMovieState({
    required this.movies,
    this.initialMovie,
    this.status = AddEditMovieStatus.initial,
    this.title = '',
    this.overview = '',
    this.vote = 0,
  });

  final List<Movie> movies;
  final Movie? initialMovie;
  final AddEditMovieStatus status;
  final String title;
  final String overview;
  final double vote;

  bool get isNewMovie => initialMovie == null;

  AddEditMovieState copyWith({
    List<Movie>? movies,
    Movie? initialMovie,
    AddEditMovieStatus? status,
    String? title,
    String? overview,
    double? vote,
  }) {
    return AddEditMovieState(
      movies: movies ?? this.movies,
      initialMovie: initialMovie ?? this.initialMovie,
      status: status ?? this.status,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      vote: vote ?? this.vote,
    );
  }

  @override
  List<Object?> get props =>
      [movies, initialMovie, status, title, overview, vote];
}
