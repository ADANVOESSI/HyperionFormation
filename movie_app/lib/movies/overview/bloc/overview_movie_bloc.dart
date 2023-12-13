import 'package:bloc/bloc.dart';
import 'package:movie_app/providers/movies_model.dart';
import 'package:movie_app/movies/overview/bloc/overview_movie_event.dart';
import 'overview_movie_state.dart';

class OverviewMovieBloc
    extends Bloc<OverviewMovieEvent, OverviewMovieState> {
  final MoviesModel _moviesModel;

  OverviewMovieBloc({required MoviesModel moviesModel})
      : _moviesModel = moviesModel,
        super(const OverviewMovieState()) {
    on<OverviewMovieSubscriptionRequested>(_onSubscriptionRequested);
    on<OverviewMovieDeleted>(_onMovieDeleted);
  }

  Future<void> _onSubscriptionRequested(
    OverviewMovieSubscriptionRequested event,
    Emitter<OverviewMovieState> emit,
  ) async {
    // A COMPLETER
  }

  Future<void> _onMovieDeleted(
    OverviewMovieDeleted event,
    Emitter<OverviewMovieState> emit,
  ) async {
    // A COMPELTER
  }
}
