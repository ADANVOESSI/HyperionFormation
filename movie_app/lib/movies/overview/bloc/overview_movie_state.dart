import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie.dart';

enum OverviewMovieStatus { initial, loading, success, failure }

final class OverviewMovieState extends Equatable {
  const OverviewMovieState({
    this.status = OverviewMovieStatus.initial,
    this.movies = const [],
  });

  final OverviewMovieStatus status;
  final List<Movie> movies;

  OverviewMovieState copyWith({
    OverviewMovieStatus Function()? status,
    List<Movie> Function()? movies,
  }) {
    return OverviewMovieState(
      status: status != null ? status() : this.status,
      movies: movies != null ? movies() : this.movies,
    );
  }

  @override
  List<Object?> get props => [status, movies];
}