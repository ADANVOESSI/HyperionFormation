import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_mobile/domains/categories.dart';
import 'package:trello_mobile/domains/membres.dart';
import 'package:trello_mobile/domains/taches.dart';
import 'package:trello_mobile/repository/categories_repository.dart';
import 'package:trello_mobile/repository/membre_repository.dart';
import 'package:trello_mobile/repository/tache_repository.dart';

class TachePage extends StatefulWidget {
  const TachePage({Key? key})
      : super(key: key);
  @override
  State<TachePage> createState() => _TachePageState();
}

class _TachePageState extends State<TachePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TacheRepositoryIpml repository = TacheRepositoryIpml();
  DateTime selectedDate = DateTime.now();
  String? selectedCategory;
  String? selectedMembre;

  _TachePageState();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        Taches taches = Taches(
          name: _nameController.text,
          description: _descriptionController.text,
          categories: selectedCategory,
          membres: selectedMembre,
          // createdAt: selectedDate,
        );

      await repository.create(taches);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Félicitation ! Votre tâche a été créée avec succès ...'),
        duration: Duration(seconds: 6),
      ));

        _nameController.clear();
        _descriptionController.clear();

      Navigator.of(context).pushNamed('/trelloPage');

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur : ${e.toString()}'),
            duration: Duration(seconds: 6),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final membreProvider = Provider.of<MembresRepositoryIpml>(context, listen: false);

    final token = 'Votre manière de récupérer le token';

    await membreProvider.fetchAndSetUser(token);
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }


  @override
  Widget build(BuildContext context) {
    final categoriesRepo = Provider.of<CategoriesRepositoryImpl>(context);
    final membres = Provider.of<MembresRepositoryIpml>(context);


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
                      'Ajout de tâche',
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
                                  labelText: 'Nom de tâche',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Nom de tâche',
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez ajouter un nom à la tâche";
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
                                controller: _descriptionController,
                                style: const TextStyle(
                                  fontSize: 18, // Taille de police pour le texte saisi
                                  fontFamily: 'Poppins', // Police pour le texte saisi
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 10.0,
                                      bottom: 10.0), // Ajout de padding à gauche ici
                                  labelText: 'Descriptions',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color:
                                    Colors.black, // Modifiez la couleur à votre guise
                                  ),
                                  hintText: 'Ajouter une description',
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Veuillez ajouter une description";
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
                              child: FutureBuilder<List<Categories>>(
                                future: categoriesRepo.get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Center(child: Text("Une erreur s'est produite"));
                                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                    List<DropdownMenuItem<String>> dropdownItems = snapshot.data!
                                        .map((categorie) => DropdownMenuItem<String>(
                                      value: categorie.name,
                                      child: Text(categorie.name),
                                    ))
                                        .toList();

                                    return DropdownButtonFormField<String>(
                                      items: dropdownItems,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 20.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        labelText: 'Catégories',
                                        labelStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color:
                                          Colors.black,
                                        ),
                                        hintText: 'Choisir une catégorie',
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value;
                                          print("Catégorie sélectionnée : $selectedCategory");
                                        });
                                      },
                                    );
                                  } else {
                                    return const Center(child: Text("Aucune catégorie trouvée"));
                                  }
                                },
                              )
                              ,
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
                              child: FutureBuilder<List<Membres>>(
                                future: membres.get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Center(child: Text("Une erreur s'est produite"));
                                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                    List<DropdownMenuItem<String>> dropdownItems = snapshot.data!
                                        .map((membres) => DropdownMenuItem<String>(
                                      value: "${membres.name} ${membres.prenom}",
                                      child: Text("${membres.name} ${membres.prenom}"),
                                    ))
                                        .toList();
                                    return DropdownButtonFormField<String>(
                                      items: dropdownItems,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 20.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        labelText: 'Membre',
                                        labelStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color:
                                          Colors.black,
                                        ),
                                        hintText: 'Choisir un membre',
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedMembre = value;
                                        });
                                      },
                                    );
                                  } else {
                                    return const Center(child: Text("Aucune catégorie trouvée"));
                                  }
                                },
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 40.0),
                              child:SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  child: Text(
                                    "Créer",
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
