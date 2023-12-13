import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trello_mobile/repository/membre_repository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MembresRepositoryIpml>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 5, 94, 150),
      body:
      SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 80.0, 0.0),
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
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF005992),
                        // opticalSize: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connectez-vous',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Votre application pour la gestion de vos tâches quotidiennes .',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 10.0),
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
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                  offset: Offset(0, 5), // Position de l'ombre
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(
                                fontSize: 18, // Taille de police pour le texte saisi
                                fontFamily: 'Poppins', // Police pour le texte saisi
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20.0,
                                    top: 20.0,
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
                              // onSaved: (value) => email = value!.trim(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15.0, // Ajustez pour obtenir l'effet désiré
                                  offset: Offset(0, 5), // Position de l'ombre
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: passwordController,
                              style: TextStyle(
                                fontSize: 18, // Taille de police pour le texte saisi
                                fontFamily: 'Poppins', // Police pour le texte saisi
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20.0,
                                    top: 20.0,
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
                                  "Se connecter",
                                  style: TextStyle(
                                    fontSize: 18,
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
                                onPressed: () async {
                                  String email = emailController.text.trim();
                                  String password = passwordController.text.trim();

                                  try {
                                    await authProvider.login(email, password);
                                    Navigator.of(context).pushReplacementNamed('/trelloPage');
                                  } catch (error) {
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Adresse email ou mot de passe invalide !')),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/password');
                    },
                    child: const Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style, // Style par défaut du texte
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Vous n'avez pas de compte ? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decorationColor: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Inscrivez-vous',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                          decorationColor: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed('/inscription');
                          },
                      ),
                    ],
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
