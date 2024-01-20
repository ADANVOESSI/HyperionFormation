import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configurations/themes.dart';
import '../provider/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  String? emailErrorText;
  String nom = '';
  String userId = '';
  String phoneNumber = '';
  String prenom = '';
  String email = '';
  String adresse = '';
  String typePiece = 'Type de pièce';
  String numPiece = '';
  DateTime createdAt = DateTime.now();

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _submitForm() async {
    final authProvider = Provider.of<MyAuthProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await authProvider.registerUser(
          userId: user!.uid,
          nom: nom,
          prenom: prenom,
          email: email,
          phoneNumber: user?.phoneNumber,
          adresse: adresse,
          typePiece: typePiece,
          numPiece: numPiece,
          createdAt: createdAt,
        );

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Contact ajouté avec succès! Vous serez redirigé pour créer votre compte dans quelques secondes!'),
          duration: Duration(seconds: 6),
        ));

        Navigator.of(context).pushNamed('/personProche');

        _resetForm();
      } catch (error) {
        print(error.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Expanded(child: Text('Une erreur est survenue lors de l\'ajout du contact.')),
              ],
            ),
            backgroundColor: Colors.grey[800],
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Réessayer',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppliColors.mybackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 28,
          icon: const Icon(
            Icons.arrow_back,
            color: AppliColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Créer votre Compte',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Vous n'avez pas de compte utilisateur alors veuillez vous inscrire pour continuer .",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AppliColors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: PhysicalShape(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                elevation: 16,
                color: AppliColors.backgroundLight,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Nom",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppliColors.mybackground,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          filled: true,
                                          fillColor: AppliColors.white,
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Veuillez renseigner votre nom";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => nom = value!.trim(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Prénom (s)",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppliColors.mybackground,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          filled: true,
                                          fillColor: AppliColors.white,
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Veuillez renseigner votre prénom";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => prenom = value!.trim(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppliColors.mybackground,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          filled: true,
                                          fillColor: AppliColors.white,
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Veuillez renseigner une adresse valide";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => email = value!.trim(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Adresse complète",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppliColors.mybackground,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          filled: true,
                                          fillColor: AppliColors.white,
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppliColors.transparent),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Veuillez renseigner votre adresse complète";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => adresse = value!.trim(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pièce d'identité (facultatif)",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppliColors.mybackground,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 15.0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    // height: 45,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w100,
                                                ),
                                                value: typePiece,
                                                items: <String>['Type de pièce', 'CNI', 'CIP', 'Passeport', 'Carte Biométrique'].map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: AppliColors.black,
                                                        // fontSize: 15,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    typePiece = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(' '),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                                              hintText: 'Numéro de pièce',
                                              filled: true,
                                            ),
                                            onSaved: (value) => numPiece = value!.trim(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 30.0),
                          width: 150,
                          child: SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF005992),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Valider",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
