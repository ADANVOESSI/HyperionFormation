import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie.dart';

import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_bloc.dart';
import 'package:movie_app/movies/add_edit/bloc/add_edit_movie_event.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  AddEditMoviePage({Key? key, this.movie}) : super(key: key);

  @override
  _AddEditMoviePageState createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  int _currentLength = 0;
  final _maxChars = 300;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _overviewController = TextEditingController();
  final _voteController = TextEditingController();
  final _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _overviewController.text = widget.movie!.overview;
      _voteController.text = widget.movie!.vote.toString();
      _idController.text = widget.movie!.id.toString();
    }
    _overviewController.addListener(_updateLength);
  }

  void _updateLength() {
    setState(() {
      _currentLength = _overviewController.text.length;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _overviewController.removeListener(_updateLength);
    _voteController.dispose();
    _idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 94, 150),
      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: Color.fromARGB(255, 5, 94, 150),
        title: Text(
          widget.movie == null ? 'Ajouter un film' : 'Editer un film',
          style: TextStyle(
            fontSize: 18,
            // fontWeight: FontWeight.w100,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.close), // Icône de signe de multiplication
          onPressed: () {
            Navigator.of(context).pop(); // Ferme la page actuelle
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(
                  fontSize: 16,
                  // Taille de police pour le texte saisi
                  fontFamily: 'Poppins', // Police pour le texte saisi
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0),
                  // Ajout de padding à gauche ici
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    // fontWeight: FontWeight.w100,
                    color: Colors
                        .black, // Modifiez la couleur à votre guise
                  ),
                  hintText: 'Entrez un titre',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Rayon arrondi
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 235, 248, 237),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Veuillez entrer un titre à votre film";
                  }
                  return null;
                },
                onChanged: (value) {
                  context
                      .read<AddEditMovieBloc>()
                      .add(AddEditMovieTitleChanged(value));
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _overviewController,
                maxLines: null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_maxChars),
                ],
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0),
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    // fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                  hintText: 'Ajouter une description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 235, 248, 237),
                    ),
                  ),
                ),
                onChanged: (value) {
                  context
                      .read<AddEditMovieBloc>()
                      .add(AddEditMovieOverviewChanged(value));
                },
              ),
              SizedBox(height: 3),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '$_currentLength/$_maxChars',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _voteController,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0),
                  labelText: 'Vote',
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    // fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                  hintText: 'Ajoutez une vote',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 235, 248, 237),
                    ),
                  ),
                ),
                onChanged: (value) {
                  context.read<AddEditMovieBloc>().add(
                      AddEditMovieVoteChanged(double.parse(value)));
                },
              ),
              SizedBox(height: 20),
              if (widget.movie == null) SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final newMovie = Movie(
                          title: _titleController.text,
                          overview: _overviewController.text,
                          vote: double.parse(_voteController.text),
                          id: DateTime.now().millisecondsSinceEpoch);

                      context
                          .read<AddEditMovieBloc>()
                          .add(OverviewMovieAdded(newMovie));

                      Future.delayed(Duration(milliseconds: 500), () {
                        Navigator.of(context).pushNamed('/listfilms');
                      });
                    } catch (e) {
                      print("Erreur lors de la conversion : $e");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Une erreur s\'est produite lors de l\'ajout du film.')));
                    }
                  }
                },
                child: Text(
                  "Valider",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Color(0xFF005992),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
