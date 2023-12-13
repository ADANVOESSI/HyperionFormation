import 'package:flutter/material.dart';
import 'package:trello_mobile/views/home_page.dart';
import 'package:trello_mobile/views/inscription_page.dart';
import 'package:trello_mobile/views/login_page.dart';
import 'package:trello_mobile/views/tache_page.dart';
import 'package:trello_mobile/views/trello_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => WelcomeScreen(),
  '/trelloPage': (context) => TrelloPage(),
  '/tache': (context) => TachePage(),
  '/login': (BuildContext context) => LoginPage(),
  '/inscription': (BuildContext context) => FormulairePage(),

  // '/accueil': (BuildContext context) => MyHomePage(),
  // '/custom': (BuildContext context) => CustomPage(),
  // '/password': (BuildContext context) => PassWordReset(),
  // '/personProche': (BuildContext context) => PersonProchePage(),
  // '/individuel': (context) => IndividuelPage(),

  // '/collectif': (context) => CollectifPage(),
};
