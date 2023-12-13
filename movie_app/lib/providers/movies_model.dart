import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:movie_app/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class MoviesModel {
  final _movies = BehaviorSubject<List<Movie>>.seeded([]);

  Stream<List<Movie>> get moviesStream => _movies.stream;

  Future<void> loadMovies() async {
    final data =
        await rootBundle.loadString('assets/data/movies.json');
    final List<dynamic> jsonData = json.decode(data) as List<dynamic>;
    final List<Movie> movies = jsonData
        .map((movieData) =>
            Movie.fromJson(movieData as Map<String, dynamic>))
        .toList();

    _movies.add(movies);
  }

  void addMovie(Movie movie) {
    final updatedMovies = List<Movie>.from(_movies.value!)
      ..add(movie);
    _movies.add(updatedMovies);
  }

  void removeMovie(Movie movie) {
    final updatedMovies = List<Movie>.from(_movies.value!)
      ..removeWhere((element) => element.id == movie.id);
    _movies.add(updatedMovies);
  }

  void editMovie(Movie updatedMovie) {
    final moviesList = _movies.value!;
    final index =
        moviesList.indexWhere((movie) => movie.id == updatedMovie.id);
    if (index != -1) {
      moviesList[index] = updatedMovie;
      _movies.add(List<Movie>.from(moviesList));
    }
  }

  void dispose() {
    _movies.close();
  }
}
