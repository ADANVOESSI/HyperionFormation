import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/add_edit_movie_page.dart';
import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_bloc.dart';
import 'package:movie_app/routes.dart';
import 'pages/home_page.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name == "/addEditMoviePage") {
          return MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => AddEditMovieBloc(),
              child: AddEditMoviePage(),
            );
          });
        }
        // Ajoutez ici d'autres routes si nécessaire
        return MaterialPageRoute(builder: (context) => HomePage());
      },
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
