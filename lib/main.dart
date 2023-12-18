import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/firebase_options.dart';
import 'package:pokemon/poke_app.dart';

import 'blocs/pokemons/pokemons_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const PokeApp());
  runApp(
    BlocProvider(
      create: (context) => PokemonsBloc(),
      child: const PokeApp(),
    ),
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<PokemonsBloc>(
    //       create: (context) => PokemonsBloc(),
    //     ),
    //     // ... Autres BlocProviders nécessaires dans votre application
    //   ],
    //   child: const PokeApp(),
    // ),
  );
}