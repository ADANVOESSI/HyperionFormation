import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:trello_mobile/domains/membres.dart';
import 'package:trello_mobile/repository/membre_repository.dart';

class FormulairePage extends StatefulWidget {
  const FormulairePage({Key? key})
      : super(key: key);
  @override
  State<FormulairePage> createState() => _FormulairePageState();
}

class _FormulairePageState extends State<FormulairePage> {
  String? emailErrorText;
  String selectedType = 'Rôle';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final MembresRepositoryIpml repository = MembresRepositoryIpml();

  _FormulairePageState();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        Membres membres = Membres(
          name: _nameController.text,
          prenom: _prenomController.text,
          phone: _telController.text,
          email: _emailController.text,
          role: selectedType,
          password: passwordController.text,
        );

        await repository.create(membres);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Contact ajouté avec succès! Vous serez redirigé pour créer votre compte dans quelques secondes!'),
          duration: Duration(seconds: 6),
        ));

        _nameController.clear();
        _prenomController.clear();
        _emailController.clear();
        _telController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Navigator.of(context).pushNamed('/login');

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(seconds: 6),
          ),
        );
        if (e.toString().contains("Email already exists")) {
          setState(() {
            emailErrorText = "L'adresse e-mail est déjà utilisée par un autre compte.";
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(emailErrorText!),
              duration: Duration(seconds: 6),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              duration: Duration(seconds: 6),
            ),
          );
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 5, 94, 150),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 00.0),

            // margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 80.0, 0.0),
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors
                            .white, // La couleur d'arrière-plan de votre choix
                        borderRadius:
                        BorderRadius.circular(15), // Arrondi des coins
                      ),
                      child: IconButton(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 50.0, 0.0),
                        iconSize: 30.0,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF005992),
                          // opticalSize: 30,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const Text(
                      'Formulaire d\'inscription',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                SingleChildScrollView(
                  child: Container(
                    child: PhysicalShape(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      elevation: 16,
                      color: Color(0xFFFFF3E0),
                      child:Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _nameController,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Nom',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Votre nom',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez renseigner votre nom";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _prenomController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Prénom',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Votre prénom',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez renseigner votre prénom";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _telController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'N° Tél:',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Votre numéro de téléphone',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez renseigner votre numéro de téléphone";
                                  }
                                  return null;
                                },
                                // onSaved: (value) => _telController = value!.trim(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Adresse électronique',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Example@gmail.com',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez renseigner votre adresse valide";
                                  }
                                  return null;
                                },
                                // onSaved: (value) => email = value!.trim(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField(
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Rôle',
                                      child: Text('Rôle'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'frontend',
                                      child: Text('Front'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'backend',
                                      child: Text('Back'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'fullstack',
                                      child: Text('Fullstack'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'base de donne',
                                      child: Text('Base de données'),
                                    ),
                                  ],
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20.0,
                                        top: 10.0,
                                        bottom: 10.0),                                    labelText: 'Option',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color:
                                      Colors.black,
                                    ),
                                    hintText: 'Rôle',
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  value: selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedType = value!;
                                    });
                              }),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Mot de passe',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Votre mot de passe',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez choisir un mot de passe';
                                  } else if (value.length < 8) {
                                    return 'Le mot de passe doit comporter au moins 8 caractères';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                    offset: Offset(0, 5), // Position de l'ombre
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                // controller: passwordController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Confirmer mot de passe',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Veuillez Confirmer mot de passe',
                                  // Pour la couleur d'arrière-plan
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez confirmer votre mot de passe';
                                  } else if (value != passwordController.text) {
                                    return 'Les mots de passe ne correspondent pas';
                                  }
                                  return null;
                                },
                                controller: confirmPasswordController,
                                // onSaved: (value) => confirmPasswordController = value!,
                                obscureText: true,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 40.0),
                              child:SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  child: Text(
                                    "S\'inscrire",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Color(0xFF005992),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _submitForm,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
// https://www.youtube.com/watch?v=eEdnry0xZVI
