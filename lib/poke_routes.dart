import 'package:go_router/go_router.dart';
import 'package:pokemon/widgets/add_pokemons.dart';
import 'package:pokemon/widgets/edit_pokemons.dart';
import 'package:pokemon/widgets/home_page.dart';

import 'models/pokemon.dart';

final pokeRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: [
        GoRoute(
          path: 'addPokemons',
          builder: (context, state) => AddPokemons(),
        ),
      ],
    ),
  ],
);
