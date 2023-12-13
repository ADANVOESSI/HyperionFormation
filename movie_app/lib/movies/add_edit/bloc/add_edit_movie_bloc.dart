import 'package:bloc/bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_event.dart';
import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_state.dart';

class AddEditMovieBloc
    extends Bloc<AddEditMovieEvent, AddEditMovieState> {
  AddEditMovieBloc() : super(AddEditMovieState(movies: [])) {
    on<AddEditMovieTitleChanged>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<AddEditMovieOverviewChanged>((event, emit) {
      emit(state.copyWith(overview: event.overview));
    });

    on<AddEditMovieVoteChanged>((event, emit) {
      emit(state.copyWith(vote: event.vote));
    });

    on<AddEditMovieSubmitted>((event, emit) {
      final newMovie = Movie(
        title: state.title,
        overview: state.overview,
        vote: state.vote,
        id: DateTime.now().millisecondsSinceEpoch,
      );
      final List<Movie> updatedMovies = List<Movie>.from(state.movies)
        ..add(newMovie); // Ajout du nouveau film ici
      emit(state.copyWith(
          movies: updatedMovies, status: AddEditMovieStatus.success));
    });

    on<OverviewMovieAdded>((event, emit) {
      final List<Movie> updatedMovies = List<Movie>.from(state.movies)
        ..add(event.movie); // Ajout du film depuis l'événement ici
      emit(state.copyWith(movies: updatedMovies));
    });
  }
}
