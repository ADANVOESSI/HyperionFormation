import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/add_edit_movie_page.dart';
import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_bloc.dart';
import 'package:movie_app/movies/overview/view/overview_movies_page.dart';
import 'package:movie_app/pages/home_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => HomePage(),
  "/addEditMoviePage": (BuildContext context) => BlocProvider(
        create: (context) => AddEditMovieBloc(),
        child: AddEditMoviePage(),
      ),
  '/listfilms': (BuildContext context) => MovieListPage(),
};
