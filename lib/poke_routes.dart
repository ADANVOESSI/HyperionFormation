import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokemon/screens/pokemons/pokemons_screen.dart';
import 'package:pokemon/widgets/add_pokemons.dart';

final pokeRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final pokemonsBloc = context.read<PokemonsBloc>(); // Récupérer l'instance de PokemonsBloc du contexte

        return PokemonsScreen(pokemonsBloc: pokemonsBloc); // Passer l'instance à PokemonsScreen
      },
      routes: [
        GoRoute(
          path: 'addPokemons',
          builder: (context, state) => const AddPokemons(),
        ),
        // ... Autres routes
      ],
    ),
  ],
);

