import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

sealed class OverviewMovieEvent extends Equatable {
  const OverviewMovieEvent();

  @override
  List<Object> get props => [];
}

final class OverviewMovieSubscriptionRequested
    extends OverviewMovieEvent {
  final BuildContext context;

  const OverviewMovieSubscriptionRequested(this.context);

  @override
  List<Object> get props => [context];
}

final class OverviewMovieDeleted extends OverviewMovieEvent {
  final Movie movie;

  const OverviewMovieDeleted(this.movie);

  @override
  List<Object> get props => [movie];
}