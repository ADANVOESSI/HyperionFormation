import 'package:flutter/material.dart';
import 'package:pokemon/widgets/add_pokemons.dart';
import 'package:pokemon/widgets/home_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => const MyHomePage(),
  '/addPokemons': (BuildContext context) => const AddPokemons(),
};
