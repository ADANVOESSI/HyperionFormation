import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/add_edit_movie_page.dart';
import 'dart:convert';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/movies/overview/widgets/movie_list_tile.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  _loadMovies() async {
    String jsonString =
        await rootBundle.loadString('assets/data/movies.json');
    Map<String, dynamic> map = json.decode(jsonString);
    List<dynamic> movieList = map['movies'];

    setState(() {
      movies = movieList.map((m) => Movie.fromJson(m)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des films")),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieListTile(
            movie: movie,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddEditMoviePage(movie: movie)),
              );
            },
            onDismissed: (direction) {
              setState(() {
                movies.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${movie.title} supprimé")),
              );
            },
          );
        },
      ),
    );
  }
}
