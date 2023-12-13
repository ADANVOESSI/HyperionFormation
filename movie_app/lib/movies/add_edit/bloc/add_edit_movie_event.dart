import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie.dart';

sealed class AddEditMovieEvent extends Equatable {
  const AddEditMovieEvent();

  @override
  List<Object> get props => [];
}

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

final class AddEditMovieTitleChanged extends AddEditMovieEvent {
  const AddEditMovieTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class AddEditMovieOverviewChanged extends AddEditMovieEvent {
  const AddEditMovieOverviewChanged(this.overview);

  final String overview;

  @override
  List<Object> get props => [overview];
}

final class AddEditMovieVoteChanged extends AddEditMovieEvent {
  const AddEditMovieVoteChanged(this.vote);

  final double vote;

  @override
  List<Object> get props => [vote];
}

final class AddEditMovieSubmitted extends AddEditMovieEvent {
  const AddEditMovieSubmitted();
}

final class OverviewMovieAdded extends AddEditMovieEvent {
  final Movie movie;

  const OverviewMovieAdded(this.movie);

  @override
  List<Object> get props => [movie];
}
